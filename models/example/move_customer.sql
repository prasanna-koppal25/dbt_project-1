{{ config(materialized='table') }}

-- Example 1: Move KYC_Done_Date to start
WITH columns_reordered_start AS (
    SELECT 
        {{ move_column_to_start(
            '"KYC_Done_Date"',
            [
                '"FirstName"',
                '"LastName"',
                '"Full_Name"',
                '"PersonEmail"',
                '"PersonGenderIdentity"',
                '"PersonBirthdate"',
                '"Street_Address_1"',
                '"Postal_Code"'
            ]
        ) }}
    FROM {{ ref('customer_data') }}
),

-- Example 2: Move PersonEmail to end
columns_reordered_end AS (
    SELECT 
        {{ move_column_to_end(
            '"PersonEmail"',
            [
                '"FirstName"',
                '"LastName"',
                '"Full_Name"',
                '"KYC_Done_Date"',
                '"PersonGenderIdentity"',
                '"PersonBirthdate"',
                '"Street_Address_1"',
                '"Postal_Code"'
            ]
        ) }}
    FROM {{ ref('customer_data') }}
),

-- Example 3: Moveto Custom position 
columns_reordered_custom AS (
    SELECT 
        {{ move_column_to_custom_position(
            '"PersonBirthdate"',
            3,
            [
                '"FirstName"',
                '"LastName"',
                '"Full_Name"',
                '"PersonEmail"',
                '"KYC_Done_Date"',
                '"PersonGenderIdentity"',
                '"Street_Address_1"',
                '"Postal_Code"'
            ]
        ) }}
    FROM {{ ref('customer_data') }}
)

-- Choose which version you want to use
SELECT * FROM columns_reordered_start
