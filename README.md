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

### Now you'll have to set the `dbt_project.yml` with some informations. Most the name, profile options and models on file end.
