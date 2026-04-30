page 50201 "Project List"
{
    PageType = List;
    SourceTable = Project;
    Caption = 'Projects';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Project Card";

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
                    ToolTip = 'Hours used so far';
                }
                field("Remaining Hours"; Rec."Remaining Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Remaining hours';
                    Style = Unfavorable;
                    StyleExpr = Rec."Remaining Hours" < 0;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Project status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewProject)
            {
                Caption = 'New Project';
                ApplicationArea = All;
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Project Card";
                RunPageMode = Create;
                ToolTip = 'Create a new project';
            }
        }
    }
}
