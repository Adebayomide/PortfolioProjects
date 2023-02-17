select * from nashvillehousing



--Standardize Date Format


select saledateconverted, convert(date,saledate)
from nashvillehousing

--Update Nashvillehousing

Update Nashvillehousing
Set saledate = convert(date,saledate)

alter table nashvillehousing
add saledateconverted date;

Update Nashvillehousing
Set saledate = convert(date,saledate)

--Populate Property Address Data

Select *
from nashvillehousing
--where propertyaddress is null
order by parcelid

--Select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddrees
--from nashvillehousing a
--join nashvillehousing b
--on a.parcelid = b.parcelid
--and a.[Unique.id] <> b.[uniqueid]
--where a.propertyaddress is null

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a

SET Propertyaddress = ISNULL(a.PropertyAddress,b.PropertyAddress)

From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


--Breaking out address into individual column (Address, City, State)

Select propertyaddress
from nashvillehousing
--where propertyaddress is null
--order by parcelid


SELECT 
SUBSTRING(Propertyaddress,1, Charindex(',', propertyaddress)-1) as address
,
SUBSTRING(Propertyaddress, Charindex(',', propertyaddress)+1, len(propertyaddress)) as address

From PortfolioProject.dbo.nashvillehousing

alter table nashvillehousing
add propertysplitaddress nvarchar(255);

Update Nashvillehousing
Set propertysplitaddress = SUBSTRING(Propertyaddress,1, Charindex(',', propertyaddress)-1) 

alter table nashvillehousing
add propertysplitcity nvarchar(255);

Update Nashvillehousing
Set propertysplitcity = SUBSTRING(Propertyaddress, Charindex(',', propertyaddress)+1, len(propertyaddress))

select * 
From PortfolioProject.dbo.nashvillehousing






Select owneraddress From PortfolioProject.dbo.nashvillehousing

select
parsename(replace(owneraddress,',','.'),3)
,parsename(replace(owneraddress,',','.'),2)
,parsename(replace(owneraddress,',','.'),1)
 From PortfolioProject.dbo.nashvillehousing


 ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From PortfolioProject.dbo.NashvilleHousing


select distinct (soldasvacant), count(soldasvacant)
From PortfolioProject.dbo.NashvilleHousing
group by soldasvacant
order by 2



select soldasvacant
, case when soldasvacant = 'y' then 'n'
 when soldasvacant = 'n' then 'no'
 else soldasvacant
 end
From PortfolioProject.dbo.NashvilleHousing

Update nashvillehousing 

set soldasvacant = case when soldasvacant = 'y' then 'n'
 when soldasvacant = 'n' then 'no'
 else soldasvacant
 end


 --Remove Duplicates

 WITH RowNumCTE AS (


select *,
    ROW_NUMBER() Over ( 
	Partition by parcelid, propertyaddress, saleprice,
	saledate,
	legalreference
	Order by  UniqueID ) row_num


From PortfolioProject.dbo.NashvilleHousing

)
select * from RowNumCTE
where row_num > 1
order by propertyaddress




--DELETE UNUSED COLUMNS

select *

From PortfolioProject.dbo.NashvilleHousing

ALter table PortfolioProject.dbo.NashvilleHousing
drop column owneraddress, taxdistrict, propertyaddress, 

ALter table PortfolioProject.dbo.NashvilleHousing
drop column saledateconverted

