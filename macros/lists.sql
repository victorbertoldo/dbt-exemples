{% set my_animals = ['lemur', 'wolf', 'panther', 'tardigrade']%}

--  {{ my_animals[0]}}

{% for animal in my_animals %}

    My favorite animal is the {{ animal }}

{% endfor %}