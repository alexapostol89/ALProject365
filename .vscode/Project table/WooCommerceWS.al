codeunit 50105 WooCommerceWS
{
    [ServiceEnabled]
    procedure CreateSalesOrder(orderPayload: Text): Text
    var
        orderJson: JsonObject;
        billingObj: JsonToken;
        billingJson: JsonObject;
        lineItemsToken: JsonToken;
        lineItemsArray: JsonArray;
        lineItemToken: JsonToken;
        lineItemJson: JsonObject;
        productIdToken: JsonToken;
        quantityToken: JsonToken;
        wooOrderIdToken: JsonToken;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        Setup: Record "WooCommerce Setup";
        WooMgt: Codeunit "WooCommerce Management";
        CustomerNo: Code[20];
        ItemNo: Code[20];
        wooProductId: Integer;
        qty: Decimal;
        lineNo: Integer;
        orderNo: Code[20];
        wooOrderId: Text;
    begin
        // 1. Get setup
        if not Setup.Get() then
            Error('WooCommerce Setup not found. Please configure it first.');

        CustomerNo := Setup."Default Customer No.";
        if CustomerNo = '' then
            Error('Default Customer No. is not set in WooCommerce Setup.');

        // 2. Parse JSON payload
        orderJson.ReadFrom(orderPayload);

        // 3. Get WooCommerce order ID
        if orderJson.Get('id', wooOrderIdToken) then
            wooOrderId := Format(wooOrderIdToken.AsValue().AsInteger())
        else
            wooOrderId := Format(CurrentDateTime());

        // 4. Create Sales Header
        orderNo := WooMgt.CreateSalesOrder(CustomerNo, wooOrderId);

        // 5. Process line items
        orderJson.Get('line_items', lineItemsToken);
        lineItemsArray := lineItemsToken.AsArray();
        lineNo := 10000;

        foreach lineItemToken in lineItemsArray do begin
            lineItemJson := lineItemToken.AsObject();
            lineItemJson.Get('product_id', productIdToken);
            lineItemJson.Get('quantity', quantityToken);

            wooProductId := productIdToken.AsValue().AsInteger();
            qty := quantityToken.AsValue().AsDecimal();

            // Find BC Item by WooCommerce ID
            Item.Reset();
            Item.SetRange("WooCommerce ID", wooProductId);
            if Item.FindFirst() then begin
                WooMgt.AddSalesLine(orderNo, Item."No.", qty, lineNo);
                lineNo += 10000;
            end;
        end;

        exit('Sales Order created successfully: ' + orderNo);
    end;
}