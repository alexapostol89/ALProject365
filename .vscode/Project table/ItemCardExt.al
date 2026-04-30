pageextension 50100 ItemCardExt extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            group(WooCommerce)
            {
                Caption = 'WooCommerce';

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
}