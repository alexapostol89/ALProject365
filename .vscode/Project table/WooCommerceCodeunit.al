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
        Item.SetRange("WooCommerce ID", 1, 999999); // only WooCommerce items
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
}