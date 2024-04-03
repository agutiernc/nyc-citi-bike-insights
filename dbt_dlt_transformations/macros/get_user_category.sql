{#
    This macro returns the user category, Member or Non-member
#}

{% macro get_user_category(user_type) -%}
   case 
      when {{ dbt.safe_cast("user_type", api.Column.translate_type("string")) }} = 'Subscriber'
         then 'Member' 
      when {{ dbt.safe_cast("user_type", api.Column.translate_type("string")) }} = 'member_casual'
         then 'Member' 
      else 'Non-Member' 
   end
{%- endmacro %}
