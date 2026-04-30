tableextension 50100 ItemTableExt extends Item
{
    fields
    {
        field(50100; "WooCommerce ID"; Integer)
        {
            Caption = 'WooCommerce ID';
            DataClassification = CustomerContent;
        }
        field(50101; "Sales Channel"; Enum SalesChannel)
        {
            Caption = 'Sales Channel';
            DataClassification = CustomerContent;
        }
    }
}