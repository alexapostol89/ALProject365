page 50200 "WooCommerce Setup"
{
    PageType = Card;
    SourceTable = "WooCommerce Setup";
    Caption = 'WooCommerce Setup';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Connection)
            {
                Caption = 'WooCommerce Connection';

                field("WooCommerce URL"; Rec."WooCommerce URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base URL of your WooCommerce store';
                }
                field("Consumer Key"; Rec."Consumer Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'WooCommerce REST API Consumer Key';
                }
                field("Consumer Secret"; Rec."Consumer Secret")
                {
                    ApplicationArea = All;
                    ToolTip = 'WooCommerce REST API Consumer Secret';
                }
            }
            group(Notifications)
            {
                Caption = 'Stock Notifications';

                field("Low Stock Threshold"; Rec."Low Stock Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Send email when stock falls below this number';
                }
                field("Notification Email"; Rec."Notification Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email address to notify when stock is low';
                }
            }
            group(Sales)
            {
                Caption = 'Sales';

                field("Default Customer No."; Rec."Default Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Default BC customer used for WooCommerce orders';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}