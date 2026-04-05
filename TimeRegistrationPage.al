page 50203 "Time Registration"
{
    PageType = List;
    SourceTable = "Time Registration";
    Caption = 'Time Registration';
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Entry number';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of the time registration';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Your employee number (auto-filled)';
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select a project you are assigned to';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Project name';
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of hours worked on this project';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of work done';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Whether this entry has been posted';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RegisterTime)
            {
                Caption = 'New Entry';
                ApplicationArea = All;
                Image = NewRow;
                Promoted = true;
                PromotedCategory = New;
                ToolTip = 'Add a new time registration entry';

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Date := Today();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(not Rec.Posted);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        exit(not Rec.Posted);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Posted then
            Error('You cannot delete a posted time registration.');
        exit(true);
    end;
}
