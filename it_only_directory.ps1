### the script creates the 'C:\it' directory and gives it access only to administrators and specified people

#creating directory
if (!(test-path 'C:\it')){
    #checking the existence of the directory; if it does not exist, the script will be run
    new-item -path 'C:\' -itemtype directory -name 'it'

    #assigning permissions information to the $directory variable
    $directory = get-acl -path 'C:\it'

    #disable inheritance
    $directory.SetAccessRuleProtection($true, $false)

    #defining variables for the class System.Security.AccessControl.FileSystemAccessRule(IdentityReference, FileSystemRights, InheritanceFlags, PropagationFlags, AccessControlType)
    #user: USER-A
    $identity1 = 'domain\USER-A'
    $rights = 'FullControl'
    $inheritance = 'ContainerInherit, ObjectInherit'
    $propagation = 'None'
    $type = 'Allow'
    $ACE1 = new-object System.Security.AccessControl.FileSystemAccessRule($identity1, $rights, $inheritance, $propagation, $type)
    $directory.AddAccessRule($ACE1)

    #user: USER-B
    $identity2 = 'domain\USER-B'
    $ACE2 = new-object System.Security.AccessControl.FileSystemAccessRule($identity2, $rights, $inheritance, $propagation, $type)
    $directory.AddAccessRule($ACE2)

    #user: USER-C
    $identity3 = 'domain\USER-C'
    $ACE3 = new-object System.Security.AccessControl.FileSystemAccessRule($identity3, $rights, $inheritance, $propagation, $type)
    $directory.AddAccessRule($ACE3)

    #user: USER-D
    $identity4 = 'domain\USER-D'
    $ACE4 = new-object System.Security.AccessControl.FileSystemAccessRule($identity4, $rights, $inheritance, $propagation, $type)
    $directory.AddAccessRule($ACE4)

    #user: SYSTEM
    $identity5 = 'SYSTEM'
    $ACE5 = new-object System.Security.AccessControl.FileSystemAccessRule($identity5, $rights, $inheritance, $propagation, $type)
    $directory.AddAccessRule($ACE5)

    #grup: Local Admins
    $identity6 = 'BUILTIN\Administrators'
    $ACE6 = new-object System.Security.AccessControl.FileSystemAccessRule($identity6, $rights, $inheritance, $propagation, $type)
    $directory.AddAccessRule($ACE6)

    #creating ACE for a new owner 'domain\USER-A'
    $owner = new-object System.Security.Principal.NTAccount('domain\USER-A')

    #changing directory owner
    $directory.setowner($owner)

    #saving changes
    set-acl -path 'C:\it' -aclobject $directory
}