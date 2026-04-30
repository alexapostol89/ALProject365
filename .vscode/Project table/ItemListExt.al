pageextension 50101 ItemListExt extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("WooCommerce ID"; Rec."WooCommerce ID")
            {
                ApplicationArea = All;
                ToolTip = 'The product ID in WooCommerce';
            }
            field("Sales Channel"; Rec."Sales Channel")
            {
                ApplicationArea = All;
                ToolTip = 'Where this product is sold';
            }
        }
    }
}