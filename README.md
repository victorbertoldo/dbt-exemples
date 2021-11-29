# Learning how dbt works
____
### Fist steps

First you'll have to install dbt, so go to the terminal e run this command

``` Shell
pip install dbt
```

Then you go to terminal again and run this to initialize the dbt folder

``` Shell
dbt init <name of it>
```

### The test that we're going to do it is on Snowflake database.

You can find de configuration [here.](https://docs.getdbt.com/reference/warehouse-profiles/snowflake-profile)

### Create your triall account on Snowflake
Once you've created your account, first things first, alter the role to accountadmin and create a DW on Warehouses setup.
After you've created with the configuration that you need, let's set the auto suspend time so we'll not be charged for inactivity time.

So, go to worksheets tab and run this code to set for 60 seconds.
``` SQL
ALTER WAREHOUSE "TRANSFORM_DW" SET WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = '';
```

### Now let's setup the dbt profile to connect on Snowflake
Go to the terminal and to see how your profile is set, run this to get the location of yml file:

``` Shell
dbt debug --config-dir

```

After that you can  open the file right in vs code, so type that and... tah dah

``` Shell
code <location of the file>\profiles.yml

```

You'll have to get the confgiration exemple given on link above and create your custom profiles file, like this bellow:

``` YML
my-test-snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: ej24830.us-east-2

      # User/password auth
      user: dbt_test
      password: dbtT3st101

      role: test_role
      database: analytics
      warehouse: transform_dw
      schema: dbt
      threads: 1
      client_session_keep_alive: False

```
> See that account set is the sub domain on your url. To fill the config file you'll have to create some things on snowflake:
>- Use a new user just for dbt, you can create on account tab;
>- Don't forget to crete a specific role as >well on same tab;
>- Create a Database and grant privileges on the role that you've created;
>- Create a schema by running this command on snowflake worksheets: `create schema analytics.dbt;`

### Now we'll have to set the `dbt_project.yml` with some informations. Most the name, profile options and models on file end. Notice that the profile config we have to set with the name of the profile.yml that we've setted before.

After we get all this setup, we can go to the terminal and run de debug command to check if connection is working fine.

``` Shell
dbt debug
```

Then we gotta be shure that our user has all the permissions, so we can run that in snowflake:
``` SQL
grant create schema on database analytics to role test_role;
grant usage on all schemas in database analytics to role test_role;
grant usage on future schemas in database analytics to role test_role;
grant select on all tables in database analytics to role test_role;
grant select on future tables in database analytics to role test_role;
grant select on all views in database analytics to role test_role;
grant select on future views in database analytics to role test_role;
```
____
### After all that we can start to create models
So, basically we have in dbt_project.yml file a place to set the directory to put models and by default we have the `example` folder.

To create a simple table we can use this sintaxe:

``` YML
{{ config(materialized='table') }}

select ...
```

To create a view:

``` YML
{{ config(materialized='view') }}

select ...
```

To create an incremental table, we'll have to declare a unique key to be referenced to do the trick:

``` YML
{{ config(materialized='incremental', unique_key='<field name>') }}

select ...
```
> But that's not all. We'll need and conditional statement like this:

``` YML
{% if is_incremental() %}
    and <field> (select max(<field>) from {{ this}})
{% endif %}

```

Also we can create an ephemeral model, who's like a temp table. But the advantages is that we can use the logic of ref to uses as a pipeline.

To create a view:

``` YML
{{ config(materialized='ephemeral') }}

select ...
```

