page 50210 "Sales By Product Chart"
{
    PageType = ListPart;
    ApplicationArea = All;
    Caption = 'Sales by Product';

    SourceTable = Item;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field(TotalSold; GetTotalSold(Rec."No."))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Sold';
                }
            }
        }
    }

    local procedure GetTotalSold(ItemNo: Code[20]): Decimal
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
        SalesInvLine.SetRange("No.", ItemNo);
        SalesInvLine.CalcSums(Quantity);
        exit(SalesInvLine.Quantity);
    end;
}