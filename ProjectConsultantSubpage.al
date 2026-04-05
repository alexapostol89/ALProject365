page 50202 "Project Consultant Subpage"
{
    PageType = ListPart;
    SourceTable = "Project Consultant";
    Caption = 'Assigned Consultants';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee number of the consultant';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the consultant';
                }
            }
        }
    }
}
