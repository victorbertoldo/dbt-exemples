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
```SQL
ALTER WAREHOUSE "TRANSFORM_DW" SET WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = '';
```