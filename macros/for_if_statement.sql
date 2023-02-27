{% set foods = ['carrot', 'hotdog', 'cucumber', 'bell pepper'] %}

{% for food in foods %}
    {% if food == 'hotdog' %}
        {% set food_type = 'snack' %}
    {% else %}
        {% set food_type = 'vegetable' %}
    {% endif %}

The humble {{ food }} is my favorite {{ food_type }}

{% endfor %}

-- You will see that in the output there is a bunch of whitespaces and newlines, because jinja considers each line of code as a new line on output. 
-- So to correct that we can add a minus sine inside of de {% ... %}, wold be like this: {%- ... -%}
-- This will remove the whitespaces and newlines from the output.