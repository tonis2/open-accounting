Open-source accounting software

Reference images at ./references

Primary features

[x] - Locally hostable, can be easily run with docker-compose
[x] - Can connect to external banks, so the BE syncs data from users bank and saves it to accounting software database, where user can add reciepts to purchases, explanations, categories, comments.
[x] - User can add projects, Projects have name, email address, description, and user can pick a project from dashboard and create invoices to it, and the invoice data is saved to database, dashboard should also keep in sync, if invoices have been paid or not via cheking the bank connections data occasionally, so user has an overview if statement has been paid.
[x] - Same tech stack as /home/tonis/Documents/flutter/geogame/ project, GO lang server, flutter front-end, Postgres database, Caddyfile, envoy for GRPC, protofile for routes, with deploymend.md tutorial.
[x] - Dashboard should also have translations file from start, and each text value on the dashboard should come from the translation file, English only at start.
[x] - Ideally user should be also able to switch between companies, same functionality for all companies, but data wont get mixed, (invoices, bank transaction ..etc)
[x] - Bank configurations should be easily addable, it should be some easy structure like a plugin, where you can add new api endpoints as banks
[x] - Passkeys for registered accounts.
[] - Multiple users, user should be able to give access to accountant, who can view acccounting data only for now.

Implemented (Sep 2026): see README.md for running and DEPLOYMENT.md for self-hosting.
Follow-ups not in v1: inviting other members to a company, more translations (only app_en.arb exists).
Bank access note (Sep 2026): Wise serves API statements to personal tokens only for US/CA/AU/NZ/SG/MY
accounts and GoCardless closed new signups, so CSV statement upload (any bank) is the primary import
path; Wise syncs balances only (in the EU/UK).
