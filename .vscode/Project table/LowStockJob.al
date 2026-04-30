codeunit 50106 LowStockJob
{
    trigger OnRun()
    begin
        CheckLowStock();
    end;

    local procedure CheckLowStock()
    var
        WooMgt: Codeunit "WooCommerce Management";
    begin
        WooMgt.CheckLowStock();
    end;
}