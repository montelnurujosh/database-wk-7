-- ==================================================
-- ASSIGNMENT: Normalization to 1NF and 2NF
-- ==================================================

-- =======================================
-- QUESTION 1: Achieving First Normal Form
-- =======================================

-- Original Problem:
-- The "Products" column had multiple values (Laptop, Mouse),
-- violating 1NF rules (atomic values only).

-- Step 1: Create ProductDetail_1NF table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert atomic values (one product per row)
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Laptop');
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (103, 'Emily Clark', 'Phone');

-- ✅ Table is now in 1NF (no repeating groups).


-- =======================================
-- QUESTION 2: Achieving Second Normal Form
-- =======================================

-- Original Problem:
-- In the 1NF table, "CustomerName" depends only on OrderID,
-- not on the full composite key (OrderID + Product).
-- This is a partial dependency, which violates 2NF.

-- Step 1: Create Orders table (stores Customer info per Order)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderDetails_2NF table (stores product-level info)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert values into Orders
INSERT INTO Orders VALUES (101, 'John Doe');
INSERT INTO Orders VALUES (102, 'Jane Smith');
INSERT INTO Orders VALUES (103, 'Emily Clark');

-- Step 4: Insert values into OrderDetails_2NF
INSERT INTO OrderDetails_2NF VALUES (101, 'Laptop', 2);
INSERT INTO OrderDetails_2NF VALUES (101, 'Mouse', 1);
INSERT INTO OrderDetails_2NF VALUES (102, 'Tablet', 3);
INSERT INTO OrderDetails_2NF VALUES (102, 'Keyboard', 1);
INSERT INTO OrderDetails_2NF VALUES (102, 'Mouse', 2);
INSERT INTO OrderDetails_2NF VALUES (103, 'Phone', 1);

-- ✅ The database is now in 2NF:
-- - Orders: holds OrderID + CustomerName
-- - OrderDetails_2NF: holds OrderID + Product + Quantity
-- - All non-key attributes depend fully on the primary key.
