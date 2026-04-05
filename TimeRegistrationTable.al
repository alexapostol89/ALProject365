table 50203 "Time Registration"
{
    DataClassification = ToBeClassified;
    Caption = 'Time Registration';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
            Editable = false;
        }
        field(3; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project No.';
            TableRelation = Project."No." where(Status = const(Open));

            trigger OnValidate()
            var
                Project: Record Project;
                ProjectConsultant: Record "Project Consultant";
            begin
                ProjectConsultant.SetRange("Project No.", "Project No.");
                ProjectConsultant.SetRange("Employee No.", "Employee No.");
                if not ProjectConsultant.FindFirst() then
                    Error('You are not assigned to project %1.', "Project No.");

                if Project.Get("Project No.") then
                    "Project Name" := Project."Project Name";
            end;
        }
        field(4; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
            Editable = false;
        }
        field(5; "Hours Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Hours Worked';
            MinValue = 0;
        }
        field(6; Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(7; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(K2; "Employee No.", "Project No.") { }
        key(K3; "Project No.") { SumIndexFields = "Hours Worked"; }
    }

    trigger OnInsert()
    var
        Employee: Record Employee;
    begin
        Date := Today();
        Employee.SetFilter("No.", '<>%1', '');
        Employee.SetRange("Search Name", CopyStr(UserId(), 1, MaxStrLen(Employee."Search Name")));
        if not Employee.FindFirst() then begin
            Employee.Reset();
            Employee.SetRange("E-Mail", CopyStr(UserId(), 1, MaxStrLen(Employee."E-Mail")));
            if Employee.FindFirst() then
                "Employee No." := Employee."No.";
        end else
            "Employee No." := Employee."No.";
    end;
}
