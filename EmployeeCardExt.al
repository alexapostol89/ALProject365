pageextension 50200 EmployeeCardExt extends "Employee Card"
{
    actions
    {
        addlast(Processing)
        {
            action(TimeRegistrations)
            {
                Caption = 'Time Registrations';
                ApplicationArea = All;
                Image = LaunchWeb;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View time registrations for this employee';

                trigger OnAction()
                var
                    TimeReg: Record "Time Registration";
                    TimeRegPage: Page "Time Registration";
                begin
                    TimeReg.SetRange("Employee No.", Rec."No.");
                    TimeRegPage.SetTableView(TimeReg);
                    TimeRegPage.RunModal();
                end;
            }
        }
    }
}
