table 50202 "Project Consultant"
{
    DataClassification = ToBeClassified;
    Caption = 'Project Consultant';

    fields
    {
        field(1; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project No.';
            TableRelation = Project."No.";
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No.") then
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee Name';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Project No.", "Employee No.") { Clustered = true; }
    }
}
