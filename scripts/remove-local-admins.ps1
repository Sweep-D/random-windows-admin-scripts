(Get-LocalGroupMember administrators | where {($_.name) -NotLike '*administrator*' -and ($_.name) -notlike '*MTITAdmin*' -and ($_.name) -notlike '*admin*' -and ($_.name) -notlike '*svc_GPService*' -and ($_.name) -notlike '*WORKGROUP\Domain Admins*'} | remove-localgroupmember administrators)

Get-localGroupMember administrators

