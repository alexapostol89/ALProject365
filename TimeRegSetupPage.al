page 50205 "Time Reg. Setup"
{
    PageType = Card;
    SourceTable = "Time Reg. Setup";
    Caption = 'Time Registration Setup';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Project Nos."; Rec."Project Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. series used for project numbers';
                }
                field("Notification Email"; Rec."Notification Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email address to receive nightly project overage notifications';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
