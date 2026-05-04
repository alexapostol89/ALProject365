page 50250 "Sales Processor Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    Caption = 'Sales Processor Dashboard';

    layout
    {
        area(RoleCenter)
        {
            part(SalesChart; "Sales By Product Chart")
            {
                ApplicationArea = All;
            }
        }
    }
}
