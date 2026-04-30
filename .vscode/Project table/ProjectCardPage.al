page 50200 "Project Card"
{
    PageType = Card;
    SourceTable = Project;
    Caption = 'Project Card';
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status of the project';
                }
            }
            group(Hours)
            {
                Caption = 'Hours';

                field("Estimated Hours"; Rec."Estimated Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total estimated hours for the project';
                }
                field("Used Hours"; Rec."Used Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hours already used';
                    Style = Attention;
                    StyleExpr = Rec."Remaining Hours" < 0;
                }
                field("Remaining Hours"; Rec."Remaining Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Remaining hours on the project';
                    Style = Unfavorable;
                    StyleExpr = Rec."Remaining Hours" < 0;
                }
            }
            part(Consultants; "Project Consultant Subpage")
            {
                ApplicationArea = All;
                Caption = 'Assigned Consultants';
                SubPageLink = "Project No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostProject)
            {
                Caption = 'Post Project';
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Close and post the project to the posted projects table';

                trigger OnAction()
                var
                    ProjectMgt: Codeunit "Project Management";
                begin
                    if Confirm('Are you sure you want to post and close project %1?', false, Rec."No.") then begin
                        ProjectMgt.PostProject(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
            action(RefreshHours)
            {
                Caption = 'Refresh Hours';
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Recalculate used and remaining hours';

                trigger OnAction()
                begin
                    Rec.UpdateHours();
                    CurrPage.Update();
                end;
            }
        }
    }
}
