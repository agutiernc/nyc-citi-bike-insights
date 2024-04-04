{#
    This macro returns the user category, Member or Non-member
#}

{% macro get_user_category(col_name) -%}
   case 
      when {{ dbt.safe_cast(col_name, api.Column.translate_type("string")) }} = 'Subscriber'
         then 'Member' 
      when {{ dbt.safe_cast(col_name, api.Column.translate_type("string")) }} = 'member'
         then 'Member' 
      else 'Non-Member' 
   end
{%- endmacro %}
