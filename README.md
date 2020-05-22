Terraform pg state store using Heroku Postgres
===========================

Setup
-----

First, install & login to [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).

🆔 *Terraform will use Heroku CLI's authorization.*

```bash
heroku whoami
heroku login
```

🔐 *Instead, optionally, [authorize Terraform with a specific API key](https://www.terraform.io/docs/providers/heroku/index.html#authentication)).*

Clone the repo:

```bash
git clone git@github.com:mars/terraform-pg-state-store.git
cd terraform-pg-state-store/
```

Initialize & apply the configuration with the required input variables:

```bash
terraform init
terraform apply -var name=my-terraform-state
```

Usage
-----

Once complete, get the Postgres credentials.

Always refresh first, to get the current credentials:

```bash
terraform refresh -var name=my-terraform-state
terraform output pg_connection_string
```

…and then, use that value to [configure the pg backend in your Terraform project](https://www.terraform.io/docs/backends/types/pg.html).

Safety
------

If you want to ensure no further Terraform actions accidently destroy the database, go ahead and delete the Terraform state:

```bash
rm terraform.tfstate*
```
