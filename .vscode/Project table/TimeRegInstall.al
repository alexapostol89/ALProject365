codeunit 50202 "Time Reg. Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetupJobQueue();
    end;

    local procedure SetupJobQueue()
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        // Check if already exists
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Time Reg. Nightly Job");
        if not JobQueueEntry.IsEmpty() then
            exit;

        // Create nightly job queue entry
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"Time Reg. Nightly Job";
        JobQueueEntry.Description := 'Time Registration Nightly Posting';
        JobQueueEntry."Run on Mondays" := true;
        JobQueueEntry."Run on Tuesdays" := true;
        JobQueueEntry."Run on Wednesdays" := true;
        JobQueueEntry."Run on Thursdays" := true;
        JobQueueEntry."Run on Fridays" := true;
        JobQueueEntry."Starting Time" := 235900T; // 23:59
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Insert(true);
    end;
}
