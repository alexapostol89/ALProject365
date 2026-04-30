table 50200 "WooCommerce Setup"
{
    DataClassification = CustomerContent;
    Caption = 'WooCommerce Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "WooCommerce URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'WooCommerce URL';
        }
        field(3; "Consumer Key"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Consumer Key';
        }
        field(4; "Consumer Secret"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Consumer Secret';
        }
        field(5; "Low Stock Threshold"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Low Stock Threshold';
            MinValue = 0;
        }
        field(6; "Notification Email"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Notification Email';
        }
        field(7; "Default Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Customer No.';
            TableRelation = Customer;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}