# OuluOpenHack API

## New Team Registration

  1. Send HTTP POST with team details [:name, members: [:email, :name] ]
  2. Send confirmation emails to all members
  3. Wait until everybody has clicked the confirmation link
    - Show "confirmed but waiting for others" page
  4. On last confirmation, show "Your team participation is confirmed" page
  5. Send event invitations to all team members
    - Team TOKEN

## Requirements

Development environment uses ```mailcatcher``` gem for receiving all emails. If you don't have it, install it by running ```gem install mailcatcher``` and run it

