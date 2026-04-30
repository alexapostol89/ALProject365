codeunit 50200 "Project Management"
{
    procedure PostProject(var Project: Record Project)
    var
        PostedProject: Record "Posted Project";
        TimeReg: Record "Time Registration";
    begin
        Project.UpdateHours();

        PostedProject.Init();
        PostedProject."No." := Project."No.";
        PostedProject."Project Name" := Project."Project Name";
        PostedProject."Estimated Hours" := Project."Estimated Hours";
        PostedProject."Used Hours" := Project."Used Hours";
        PostedProject."Remaining Hours" := Project."Remaining Hours";
        PostedProject."Posted Date" := Today();
        PostedProject.Insert();

        TimeReg.SetRange("Project No.", Project."No.");
        TimeReg.SetRange(Posted, false);
        if TimeReg.FindSet(true) then
            repeat
                TimeReg.Posted := true;
                TimeReg.Modify();
            until TimeReg.Next() = 0;

        Project.Delete(true);

        Message('Project %1 has been successfully posted and closed.', PostedProject."No.");
    end;

    procedure PostAllTimeRegistrations()
    var
        TimeReg: Record "Time Registration";
        Project: Record Project;
    begin
        TimeReg.SetRange(Posted, false);
        if TimeReg.FindSet(true) then
            repeat
                TimeReg.Posted := true;
                TimeReg.Modify();
            until TimeReg.Next() = 0;

        Project.SetRange(Status, Project.Status::Open);
        if Project.FindSet(true) then
            repeat
                Project.UpdateHours();
            until Project.Next() = 0;

        SendOverageNotification();
    end;

    local procedure SendOverageNotification()
    var
        Project: Record Project;
        TimeRegSetup: Record "Time Reg. Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
    begin
        if not TimeRegSetup.Get() then
            exit;
        if TimeRegSetup."Notification Email" = '' then
            exit;

        Project.SetRange(Status, Project.Status::Open);
        Project.SetFilter("Remaining Hours", '<%1', 0);
        if not Project.FindSet() then
            exit;

        EmailBody := 'The following projects have exceeded their estimated hours:<br><br>';
        EmailBody += '<table><tr><th>Project No.</th><th>Project Name</th><th>Estimated</th><th>Used</th><th>Remaining</th></tr>';
        repeat
            EmailBody += '<tr><td>' + Project."No." + '</td><td>' + Project."Project Name" + '</td><td>' +
                         Format(Project."Estimated Hours") + '</td><td>' +
                         Format(Project."Used Hours") + '</td><td>' +
                         Format(Project."Remaining Hours") + '</td></tr>';
        until Project.Next() = 0;
        EmailBody += '</table>';

        EmailMessage.Create(
            TimeRegSetup."Notification Email",
            'Projects with Negative Remaining Hours - ' + Format(Today()),
            EmailBody,
            true);
        Email.Send(EmailMessage);
    end;
}
