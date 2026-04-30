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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sales Channel"; Rec."Sales Channel")
                {
                    ApplicationArea = All;
                }
                field(TotalSold; GetTotalSold(Rec."No."))
                {
                    ApplicationArea = All;
                    Caption = 'Total Qty Sold';
                }
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
                ToolTip = 'Open the Item Card for the selected product';

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

    local procedure GetTotalSold(ItemNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", ItemNo);
        SalesLine.CalcSums(Quantity);
        exit(SalesLine.Quantity);
    end;
}