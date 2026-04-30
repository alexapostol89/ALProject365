codeunit 50100 StudentWS
{
    [ServiceEnabled]
    procedure HelloWorld(): Text
    begin
        exit('Hello from Business Central');
    end;

    [ServiceEnabled]
    procedure createstudentjs(student: Text): Text
    var
        studentRec: Record Student;
        orderPayload: JsonObject;
        billingObj: JsonToken;
        billingJson: JsonObject;
        firstNameToken: JsonToken;
        lastNameToken: JsonToken;
        emailToken: JsonToken;
        newNo: Code[20];
        fullName: Text;
    begin
        // Parse the incoming WooCommerce JSON
        orderPayload.ReadFrom(student);

        // Navigate into the "billing" object
        orderPayload.Get('billing', billingObj);
        billingJson := billingObj.AsObject();

        // Extract fields from billing
        billingJson.Get('first_name', firstNameToken);
        billingJson.Get('last_name', lastNameToken);
        billingJson.Get('email', emailToken);

        // Combine first + last name
        fullName := firstNameToken.AsValue().AsText() + ' ' + lastNameToken.AsValue().AsText();

        // Generate student number from current time
        newNo := CopyStr(Format(CurrentDateTime(), 0, '<Day,2><Month,2><Hours24,2><Minutes,2><Seconds,2>'), 1, 20);

        // Insert into Student table
        studentRec.Init();
        studentRec."Student No." := newNo;
        studentRec.Name := CopyStr(fullName, 1, MaxStrLen(studentRec.Name));
        studentRec.Email := CopyStr(emailToken.AsValue().AsText(), 1, MaxStrLen(studentRec.Email));
        studentRec.Insert(true);

        exit('Student created: ' + studentRec.Name + ' | ' + studentRec.Email);
    end;
}