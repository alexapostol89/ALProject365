codeunit 50201 "Time Reg. Nightly Job"
{
    trigger OnRun()
    var
        ProjectMgt: Codeunit "Project Management";
    begin
        ProjectMgt.PostAllTimeRegistrations();
    end;
}
