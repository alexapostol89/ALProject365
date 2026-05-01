codeunit 50108 "WooCommerce Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure TestCreateSalesOrder()
    var
        SalesHeader: Record "Sales Header";
        WooMgt: Codeunit "WooCommerce Management";
        OrderNo: Code[20];
        CustomerNo: Code[20];
    begin
        // GIVEN
        CustomerNo := CreateTestCustomer();

        // WHEN
        OrderNo := WooMgt.CreateSalesOrder(CustomerNo, 'WOO-TEST-001');

        // THEN
        SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo);
        if SalesHeader."Sell-to Customer No." <> CustomerNo then
            Error('Customer No. mismatch: expected %1, got %2',
                CustomerNo, SalesHeader."Sell-to Customer No.");
        if SalesHeader."External Document No." <> 'WOO-TEST-001' then
            Error('External Doc No. mismatch');

        SalesHeader.Delete(true);
    end;

    [Test]
    procedure TestAddSalesLine()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        WooMgt: Codeunit "WooCommerce Management";
        OrderNo: Code[20];
    begin
        // GIVEN
        OrderNo := WooMgt.CreateSalesOrder(CreateTestCustomer(), 'WOO-TEST-002');

        // WHEN
        WooMgt.AddSalesLine(OrderNo, CreateTestItem(), 3, 10000);

        // THEN
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", OrderNo);
        if not SalesLine.FindFirst() then
            Error('Sales line was not created');
        if SalesLine.Quantity <> 3 then
            Error('Quantity mismatch: expected 3, got %1', SalesLine.Quantity);

        SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo);
        SalesHeader.Delete(true);
    end;

    local procedure CreateTestCustomer(): Code[20]
    var
        Customer: Record Customer;
    begin
        if Customer.Get('TEST-CUST') then
            exit('TEST-CUST');
        Customer.Init();
        Customer."No." := 'TEST-CUST';
        Customer.Name := 'Test Customer';
        Customer.Insert(true);
        exit(Customer."No.");
    end;

    local procedure CreateTestItem(): Code[20]
    var
        Item: Record Item;
    begin
        if Item.Get('TEST-ITEM') then
            exit('TEST-ITEM');
        Item.Init();
        Item."No." := 'TEST-ITEM';
        Item.Description := 'Test Item';
        Item.Type := Item.Type::Inventory;
        Item.Insert(true);
        exit(Item."No.");
    end;
}