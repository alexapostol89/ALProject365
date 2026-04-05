page 50204 "Posted Project List"
{
    PageType = List;
    SourceTable = "Posted Project";
    Caption = 'Posted Projects';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Project number';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the project';
                }
                field("Estimated Hours"; Rec."Estimated Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total estimated hours';
                }
                field("Used Hours"; Rec."Used Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hours used';
                }
                field("Remaining Hours"; Rec."Remaining Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Remaining hours at time of posting';
                    Style = Unfavorable;
                    StyleExpr = Rec."Remaining Hours" < 0;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date the project was posted/closed';
                }
            }
        }
    }
}
