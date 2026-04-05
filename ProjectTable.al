table 50200 Project
{
    DataClassification = ToBeClassified;
    Caption = 'Project';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    TimeRegSetup.Get();
                    NoSeriesMgt.TestManual(TimeRegSetup."Project Nos.");
                end;
            end;
        }
        field(2; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(3; "Estimated Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Estimated Hours';
            MinValue = 0;
        }
        field(4; "Used Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Used Hours';
            Editable = false;
        }
        field(5; "Remaining Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Hours';
            Editable = false;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = Open,Closed;
            OptionCaption = 'Open,Closed';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    var
        TimeRegSetup: Record "Time Reg. Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            TimeRegSetup.Get();
            TimeRegSetup.TestField("Project Nos.");
            NoSeriesMgt.InitSeries(TimeRegSetup."Project Nos.", xRec."No.", 0D, "No.", TimeRegSetup."Project Nos.");
        end;
    end;

    procedure UpdateHours()
    var
        TimeReg: Record "Time Registration";
    begin
        TimeReg.SetRange("Project No.", "No.");
        TimeReg.CalcSums("Hours Worked");
        "Used Hours" := TimeReg."Hours Worked";
        "Remaining Hours" := "Estimated Hours" - "Used Hours";
        Modify();
    end;
}
