-- Database: Northwind
select * from products;

--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
select product_name,quantity_per_unit from products;

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
select product_id,product_name from products
where discontinued=1;

--3. Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
select product_id,product_name from products
where discontinued=0;

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
select product_id,product_name,unit_price from products
where unit_price<20;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
select product_id,product_name,unit_price from products
where unit_price between 15 and 25;

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
select product_name,units_on_order,units_in_stock from products
where units_in_stock<units_on_order;

--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
select * from products
where product_name like 'A%';

--8. İsmi `i` ile biten ürünleri listeleyeniz.
select * from products
where product_name like '%i';

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
--select product_name,unit_price,(unit_price*1.18) as "UnitPriceKDV",(unit_price+unit_price*0.18) from products;
select product_name,unit_price,cast((unit_price*1.18) as real) as "UnitPriceKDV" from products;

--10. Fiyatı 30 dan büyük kaç ürün var?
select count(*) as "ProductCount" from products
where unit_price>30;

--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
select lower(product_name),unit_price from products
order by unit_price desc;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
select concat(first_name,' ',last_name) as "Full Name" from employees;

--13. Region alanı NULL olan kaç tedarikçim var?
select * from suppliers;
select count(*) from suppliers
where region is null;

--14. a.Null olmayanlar?
select count(*) from suppliers
where region is not null;

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
select concat('TR',upper(product_name)) as "ProductName" from products;

--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
select concat('TR',product_name) as "ProductName",unit_price from products
where unit_price<20;

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products
order by unit_price desc
limit 1;

--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products
order by unit_price desc
limit 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products
where unit_price>(select avg(unit_price) from products);

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
--select product_name,unit_price,units_in_stock,(unit_price*units_in_stock) as "satismiktari" from products;
select sum(unit_price*units_in_stock) as "toplamsatismiktari" from products;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
select count(*) from products
where discontinued=0 or discontinued=1;

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
select p.product_name,c.category_name from products p
join categories c on c.category_id = p.category_id;


--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
select c.category_id,c.category_name,cast(avg(p.unit_price) as real) as "ortalamafiyat" from categories c
inner join products p on p.category_id = c.category_id
group by c.category_id;

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
select p.product_name,p.unit_price,c.category_name from products p
join categories c on c.category_id = p.category_id
order by unit_price desc
limit 1;

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
select p.product_name,c.category_name,s.company_name,sum(od.quantity) as totalquantity from order_details as od
inner join products as p on od.product_id = p.product_id
inner join suppliers as s on p.supplier_id = s.supplier_id
inner join categories as c on p.category_id = c.category_id
group by p.product_id,c.category_name,s.company_name
order by sum(od.quantity) desc limit 1;










