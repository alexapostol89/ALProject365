table 50204 "Time Reg. Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Time Registration Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(2; "Project Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Notification Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notification Email';
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
