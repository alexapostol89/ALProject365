codeunit 50200 "WooCommerce Management"
{
    procedure CreateSalesOrder(CustomerNo: Code[20]; WooOrderId: Text): Code[20]
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."Sell-to Customer No." := CustomerNo;
        SalesHeader."External Document No." := CopyStr(WooOrderId, 1, MaxStrLen(SalesHeader."External Document No."));
        SalesHeader.Insert(true);
        SendOrderConfirmation(SalesHeader."No.", WooOrderId);
        exit(SalesHeader."No.");
    end;

    procedure AddSalesLine(SalesHeaderNo: Code[20]; ItemNo: Code[20]; Qty: Decimal; LineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, SalesHeaderNo);
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeaderNo;
        SalesLine."Line No." := LineNo;
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine."No." := ItemNo;
        SalesLine.Quantity := Qty;
        SalesLine.Insert(true);
    end;

    procedure CheckLowStock()
    var
        Item: Record Item;
        Setup: Record "WooCommerce Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
        HasLowStock: Boolean;
    begin
        if not Setup.Get() then
            exit;
        if Setup."Notification Email" = '' then
            exit;

        HasLowStock := false;
        EmailBody := 'The following items are low on stock:<br><br>';
        EmailBody += '<table><tr><th>Item No.</th><th>Description</th><th>Stock</th><th>Threshold</th></tr>';

        Item.Reset();
        Item.SetRange("WooCommerce ID", 1, 999999);
        if Item.FindSet() then
            repeat
                if Item.Inventory <= Setup."Low Stock Threshold" then begin
                    HasLowStock := true;
                    EmailBody += '<tr><td>' + Item."No." + '</td><td>' + Item.Description + '</td><td>' +
                                 Format(Item.Inventory) + '</td><td>' +
                                 Format(Setup."Low Stock Threshold") + '</td></tr>';
                end;
            until Item.Next() = 0;

        EmailBody += '</table>';

        if HasLowStock then begin
            EmailMessage.Create(
                Setup."Notification Email",
                'Low Stock Alert - ' + Format(Today()),
                EmailBody,
                true);
            Email.Send(EmailMessage);
        end;
    end;

    procedure SendOrderConfirmation(SalesOrderNo: Code[20]; WooOrderId: Text)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Setup: Record "WooCommerce Setup";
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        EmailBody: Text;
        RecipientEmail: Text;
    begin
        if not Setup.Get() then
            exit;
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo) then
            exit;

        // Get customer email
        if Customer.Get(SalesHeader."Sell-to Customer No.") then
            RecipientEmail := Customer."E-Mail";

        // Fallback to setup notification email
        if RecipientEmail = '' then
            RecipientEmail := Setup."Notification Email";

        if RecipientEmail = '' then
            exit;

        EmailBody := '<h2>Order Confirmation</h2>';
        EmailBody += '<p>Thank you for your order!</p>';
        EmailBody += '<p><strong>Order No.:</strong> ' + SalesOrderNo + '</p>';
        EmailBody += '<p><strong>WooCommerce Order No.:</strong> ' + WooOrderId + '</p>';
        EmailBody += '<p>We will process your order shortly.</p>';
        EmailBody += '<br><p>Best regards,<br>ERPProject Web Shop</p>';

        EmailMessage.Create(
            RecipientEmail,
            'Order Confirmation - ' + SalesOrderNo,
            EmailBody,
            true);
        Email.Send(EmailMessage);
    end;
}