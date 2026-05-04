page 50202 "Sales Order Processor"
{
    PageType = List;
    Caption = 'Sales Order Processor';
    ApplicationArea = All;
    UsageCategory = Documents;

    SourceTable = Item;
    SourceTableView = where("WooCommerce ID" = filter('>0'));

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item number';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Item description';
                }
            }
        }

        area(FactBoxes)
        {
            part(SalesByProduct; "Sales By Product Chart")
            {
                ApplicationArea = All;
                Caption = 'Sales by Product';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenItemCard)
            {
                Caption = 'Open Item Card';
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemCard: Page "Item Card";
                begin
                    ItemCard.SetRecord(Rec);
                    ItemCard.Run();
                end;
            }
        }
    }
}
