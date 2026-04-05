table 50201 "Posted Project"
{
    DataClassification = ToBeClassified;
    Caption = 'Posted Project';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
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
        }
        field(4; "Used Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Used Hours';
        }
        field(5; "Remaining Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Hours';
        }
        field(6; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Date';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}
