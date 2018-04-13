Irish Hospital Waiting List November 2017
================
Azmir Fakkri
13/4/2018

``` r
#install and load packages
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(gridExtra)
library(grid)
library(knitr)
library(kableExtra)

# Load data
wl_raw <- read.csv("https://raw.githubusercontent.com/azmirfakkri/datascience-projects/master/Datasets/IPDC%20Waiting%20List%20By%20Group%20Hospital%202017.csv", 
                     header = TRUE, sep = ",")

# View the whole data structure
glimpse(wl_raw)
```

    ## Observations: 49,739
    ## Variables: 11
    ## $ Archive.Date   <fctr> 2017-01-31, 2017-01-31, 2017-01-31, 2017-01-31...
    ## $ Group          <fctr> Children's Hospital Group, Children's Hospital...
    ## $ Hospital.HIPE  <int> 940, 940, 940, 940, 940, 940, 940, 940, 940, 94...
    ## $ Hospital       <fctr> Childrens University Hospital Temple Street, C...
    ## $ Specialty.HIPE <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 600, 600, 6...
    ## $ Speciality     <fctr> Small Volume Specialities, Small Volume Specia...
    ## $ Case.Type      <fctr> Day Case, Day Case, Day Case, Day Case, Day Ca...
    ## $ Adult.Child    <fctr> Child, Child, Child, Child, Child, Child, Chil...
    ## $ Age.Profile    <fctr> 0-15, 0-15, 0-15, 0-15, 0-15, 0-15, 16-64, 16-...
    ## $ Time.Bands     <fctr>  0-3 Months,  3-6 Months,  6-9 Months,  9-12 M...
    ## $ Total          <int> 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 1, 1, 26, 4, 2, 2...

``` r
# Check for missing values
any(is.na(wl_raw))
```

    ## [1] FALSE

``` r
# View head
kable(head(wl_raw), "html", caption = "Irish Hospital Waiting List 2017") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>
Irish Hospital Waiting List 2017
</caption>
<thead>
<tr>
<th style="text-align:left;">
Archive.Date
</th>
<th style="text-align:left;">
Group
</th>
<th style="text-align:right;">
Hospital.HIPE
</th>
<th style="text-align:left;">
Hospital
</th>
<th style="text-align:right;">
Specialty.HIPE
</th>
<th style="text-align:left;">
Speciality
</th>
<th style="text-align:left;">
Case.Type
</th>
<th style="text-align:left;">
Adult.Child
</th>
<th style="text-align:left;">
Age.Profile
</th>
<th style="text-align:left;">
Time.Bands
</th>
<th style="text-align:right;">
Total
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2017-01-31
</td>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:right;">
940
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
Small Volume Specialities
</td>
<td style="text-align:left;">
Day Case
</td>
<td style="text-align:left;">
Child
</td>
<td style="text-align:left;">
0-15
</td>
<td style="text-align:left;">
0-3 Months
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
2017-01-31
</td>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:right;">
940
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
Small Volume Specialities
</td>
<td style="text-align:left;">
Day Case
</td>
<td style="text-align:left;">
Child
</td>
<td style="text-align:left;">
0-15
</td>
<td style="text-align:left;">
3-6 Months
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
2017-01-31
</td>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:right;">
940
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
Small Volume Specialities
</td>
<td style="text-align:left;">
Day Case
</td>
<td style="text-align:left;">
Child
</td>
<td style="text-align:left;">
0-15
</td>
<td style="text-align:left;">
6-9 Months
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
2017-01-31
</td>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:right;">
940
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
Small Volume Specialities
</td>
<td style="text-align:left;">
Day Case
</td>
<td style="text-align:left;">
Child
</td>
<td style="text-align:left;">
0-15
</td>
<td style="text-align:left;">
9-12 Months
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
2017-01-31
</td>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:right;">
940
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
Small Volume Specialities
</td>
<td style="text-align:left;">
Day Case
</td>
<td style="text-align:left;">
Child
</td>
<td style="text-align:left;">
0-15
</td>
<td style="text-align:left;">
12-15 Months
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
2017-01-31
</td>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:right;">
940
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
Small Volume Specialities
</td>
<td style="text-align:left;">
Day Case
</td>
<td style="text-align:left;">
Child
</td>
<td style="text-align:left;">
0-15
</td>
<td style="text-align:left;">
15-18 Months
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
Data Analysis
=============

As November is the most recent snapshot of the waiting list in Irish public hospitals, a subset of the data is created and analyses will be focused on that particular month.

``` r
# November Cases
wl_nov <- wl_raw %>% filter(Archive.Date == "2017-11-30")

# Plot 1: Total Cases by Hospital Group in Nov 2017
wl_nov %>% group_by(Group, Hospital) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = Group, y = Total_Cases, fill = Group)) + 
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Hospital Group in Nov 2017",
       y = "Total Cases") +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank())
```

<img src="Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

From the bar chart, it can be seen that there are seven hospital groups in Ireland. Every hospital group is associated with a few hospitals in Ireland. Saolta University Health Care Group recorded the highest number of patients in the waiting list.

In November 2017, the total number of patients in the waiting list is 80595. This is an interesting point as a number of major Irish newspapers are quoting a much higher number in, 687000 (RTE, August 2017) and 680000 (Irish Times, October 2017). From a quick research, the data used by Irish Times and RTE are also sourced from NTPF.

``` r
# Hospitals by Group
hosp_group <- wl_nov %>% group_by(Group, Hospital) %>%
  summarise(Total_Cases = sum(Total))

kable(hosp_group, "html", caption = "Hospital Group and Total Cases") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<caption>
Hospital Group and Total Cases
</caption>
<thead>
<tr>
<th style="text-align:left;">
Group
</th>
<th style="text-align:left;">
Hospital
</th>
<th style="text-align:right;">
Total\_Cases
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:left;">
Childrens University Hospital Temple Street
</td>
<td style="text-align:right;">
1155
</td>
</tr>
<tr>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:left;">
Our Lady's Children's Hospital Crumlin
</td>
<td style="text-align:right;">
2790
</td>
</tr>
<tr>
<td style="text-align:left;">
Children's Hospital Group
</td>
<td style="text-align:left;">
Tallaght Children's Hospital
</td>
<td style="text-align:right;">
654
</td>
</tr>
<tr>
<td style="text-align:left;">
Dublin Midlands Hospital Group
</td>
<td style="text-align:left;">
Midland Regional Hospital Portlaoise
</td>
<td style="text-align:right;">
435
</td>
</tr>
<tr>
<td style="text-align:left;">
Dublin Midlands Hospital Group
</td>
<td style="text-align:left;">
Midland Regional Hospital Tullamore
</td>
<td style="text-align:right;">
2017
</td>
</tr>
<tr>
<td style="text-align:left;">
Dublin Midlands Hospital Group
</td>
<td style="text-align:left;">
Naas General Hospital
</td>
<td style="text-align:right;">
79
</td>
</tr>
<tr>
<td style="text-align:left;">
Dublin Midlands Hospital Group
</td>
<td style="text-align:left;">
St. James's Hospital
</td>
<td style="text-align:right;">
5319
</td>
</tr>
<tr>
<td style="text-align:left;">
Dublin Midlands Hospital Group
</td>
<td style="text-align:left;">
Tallaght Hospital
</td>
<td style="text-align:right;">
4325
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
Cappagh National Orthopaedic Hospital
</td>
<td style="text-align:right;">
1786
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
Mater Misericordiae University Hospital
</td>
<td style="text-align:right;">
6088
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
Midland Regional Hospital Mullingar
</td>
<td style="text-align:right;">
207
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
Our Lady's Hospital Navan
</td>
<td style="text-align:right;">
559
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
Royal Victoria Eye and Ear Hospital
</td>
<td style="text-align:right;">
2426
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
St. Columcille's Hospital
</td>
<td style="text-align:right;">
213
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
St. Luke's General Hospital Kilkenny
</td>
<td style="text-align:right;">
681
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
St. Michael's Hospital Dun Laoghaire
</td>
<td style="text-align:right;">
711
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
St. Vincent's University Hospital
</td>
<td style="text-align:right;">
2182
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland East Hospital Group
</td>
<td style="text-align:left;">
Wexford General Hospital
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
RCSI Hospitals Group
</td>
<td style="text-align:left;">
Beaumont Hospital
</td>
<td style="text-align:right;">
6200
</td>
</tr>
<tr>
<td style="text-align:left;">
RCSI Hospitals Group
</td>
<td style="text-align:left;">
Cavan General Hospital
</td>
<td style="text-align:right;">
505
</td>
</tr>
<tr>
<td style="text-align:left;">
RCSI Hospitals Group
</td>
<td style="text-align:left;">
Connolly Hospital
</td>
<td style="text-align:right;">
1309
</td>
</tr>
<tr>
<td style="text-align:left;">
RCSI Hospitals Group
</td>
<td style="text-align:left;">
Louth County Hospital
</td>
<td style="text-align:right;">
524
</td>
</tr>
<tr>
<td style="text-align:left;">
RCSI Hospitals Group
</td>
<td style="text-align:left;">
Our Lady of Lourdes Hospital Drogheda
</td>
<td style="text-align:right;">
861
</td>
</tr>
<tr>
<td style="text-align:left;">
Saolta University Health Care Group
</td>
<td style="text-align:left;">
Galway University Hospital
</td>
<td style="text-align:right;">
11362
</td>
</tr>
<tr>
<td style="text-align:left;">
Saolta University Health Care Group
</td>
<td style="text-align:left;">
Letterkenny General Hospital
</td>
<td style="text-align:right;">
2642
</td>
</tr>
<tr>
<td style="text-align:left;">
Saolta University Health Care Group
</td>
<td style="text-align:left;">
Mayo General Hospital
</td>
<td style="text-align:right;">
1632
</td>
</tr>
<tr>
<td style="text-align:left;">
Saolta University Health Care Group
</td>
<td style="text-align:left;">
Portiuncula Hospital
</td>
<td style="text-align:right;">
267
</td>
</tr>
<tr>
<td style="text-align:left;">
Saolta University Health Care Group
</td>
<td style="text-align:left;">
Roscommon Hospital
</td>
<td style="text-align:right;">
2073
</td>
</tr>
<tr>
<td style="text-align:left;">
Saolta University Health Care Group
</td>
<td style="text-align:left;">
Sligo Regional Hospital
</td>
<td style="text-align:right;">
3205
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Bantry General Hospital
</td>
<td style="text-align:right;">
22
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Cork University Hospital
</td>
<td style="text-align:right;">
1431
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Cork University Maternity Hospital
</td>
<td style="text-align:right;">
409
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Kerry General Hospital
</td>
<td style="text-align:right;">
155
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Lourdes Orthopaedic Hospital Kilcreene
</td>
<td style="text-align:right;">
325
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Mallow General Hospital
</td>
<td style="text-align:right;">
162
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
Mercy University Hospital
</td>
<td style="text-align:right;">
1284
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
South Infirmary Victoria University Hospital
</td>
<td style="text-align:right;">
2642
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
South Tipperary General Hospital
</td>
<td style="text-align:right;">
215
</td>
</tr>
<tr>
<td style="text-align:left;">
South/South West Hospital Group
</td>
<td style="text-align:left;">
University Hospital Waterford
</td>
<td style="text-align:right;">
5856
</td>
</tr>
<tr>
<td style="text-align:left;">
University of Limerick Hospital Group
</td>
<td style="text-align:left;">
Croom Orthopaedic Hospital
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
University of Limerick Hospital Group
</td>
<td style="text-align:left;">
Ennis Hospital
</td>
<td style="text-align:right;">
728
</td>
</tr>
<tr>
<td style="text-align:left;">
University of Limerick Hospital Group
</td>
<td style="text-align:left;">
Nenagh Hospital
</td>
<td style="text-align:right;">
861
</td>
</tr>
<tr>
<td style="text-align:left;">
University of Limerick Hospital Group
</td>
<td style="text-align:left;">
St. John's Hospital Limerick
</td>
<td style="text-align:right;">
1032
</td>
</tr>
<tr>
<td style="text-align:left;">
University of Limerick Hospital Group
</td>
<td style="text-align:left;">
University Hospital Limerick
</td>
<td style="text-align:right;">
2787
</td>
</tr>
</tbody>
</table>
All hospitals associated with each group can be seen in the table above along with the total number of patients in the waiting list for November 2017.

``` r
# Total Cases by Hospital in Nov 2017
wl_nov %>% group_by(Group, Hospital) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = reorder(Hospital, Total_Cases),
                          y = Total_Cases,
                          fill = Total_Cases)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Hospital in Nov 2017",
       x = "Hospital",
       y = "Total Cases") +
  scale_fill_continuous(guide = "none", low ="blue", high ="red") +
  coord_flip()
```

<img src="Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png" style="display: block; margin: auto auto auto 0;" />

Galway University Hospital has the highest number of patients in the waiting list in November 2017.
Five of the top 10 hospitals with highest number of waiting list cases are located in Dublin, including Beaumont Hospital, Mater Misericordiae University Hospital, St. James’s Hospital, Tallaght Hospital and Our Lady’s Children Hospital Crumlin.

``` r
# Total Cases by Patient Type and Case Type
wl_nov %>% group_by(Adult.Child, Case.Type) %>%
  summarise(Total_Cases = sum(Total)) %>%
  ggplot(aes(x = Adult.Child, y = Total_Cases, fill = Case.Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Cases by Patient Type and Case Type",
       x = "Patient Type",
       y = "Total Cases") +
  geom_text(aes(label = Total_Cases), position = position_stack(vjust = 0.5),
            colour = "white", size = 3) +
  scale_fill_discrete(name = "Case Type") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
```

![](Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

The number of adult patients in the waiting list are almost 10 times higher than child patients. In both group of patients, the number of day case is higher than inpatient case.

``` r
# Total Cases by Case Type and Age Profile
wl_nov %>% group_by(Case.Type, Age.Profile) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = Case.Type, y = Total_Cases, fill = Age.Profile)) +
  geom_bar(stat = "identity") +
  labs(title = "Cases by Case Type and Age Profile",
       x = "Case Type",
       y = "Total Cases") +
  geom_text(aes(label = Total_Cases), position = position_stack(vjust = 0.5),
            colour = "white", size = 3) +
  scale_fill_discrete(name = "Age Profile") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
```

![](Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

In general, day case has more patients in the waiting list compared to inpatient case. There is a higher number of patients aged between 16 to 64 years old in the waiting list for both categories compared to the rest of the age profiles.

``` r
# Total Cases by Month by Hospital Group
total_bydate <- wl_raw %>% group_by(Archive.Date, Group) %>%
  summarise(Average_Cases = mean(Total))

total_bydate2 <- separate(total_bydate, "Archive.Date", c("Year", "Month", "Day"), sep = "-")
total_bymonth <- total_bydate2[ , c(-1, -3)]

# Plot 5: Monthly Average Cases by Hospital Group
ggplot(total_bymonth, aes(x = Month, y = Average_Cases, colour = Group, group = Group)) + 
  geom_point() +
  geom_line() +
  labs(title = "Monthly Average Cases by Hospital Group",
       y = "Average Cases")
```

![](Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

From January to November 2017, only a minimal reduction in the average number of patients in the waiting list across all hospital groups can be seen except for RCSI Hospitals Group.

``` r
# Total Cases by Speciality based on Case Type in Nov 2017
wl_nov %>% group_by(Speciality, Case.Type) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = reorder(Speciality, -Total_Cases),
                          y = Total_Cases,
                          fill = Case.Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Speciality based on Case Type in Nov 2017",
       x = "Speciality",
       y = "Total Cases") +
  scale_fill_discrete(name = "Case Type") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 1))
```

<img src="Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

The top five specialties with the most patients in the waiting list are led by Orthopaedics, followed by Ophthalmology, Urology, General Surgery and Otolaryngology (ENT).
Orthopaedics has an almost balanced number of day case and inpatient case, however, Ophthalmology has a lot of day case patients compared to inpatient case in the waiting list.

``` r
# Total Cases by Time Bands based on Patient Type in Nov 2017
wl_nov %>% group_by(Time.Bands, Adult.Child) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(Time.Bands, Total_Cases, fill = Adult.Child)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = Total_Cases),size = 3, position = position_dodge(0.9),
            vjust = 1.1, color = "white") +
  labs(title = "Total Cases by Time Bands based on Patient Type in Nov 2017",
       x = "Time Bands",
       y = "Total Cases") +
  scale_fill_discrete(name = "Patient Type") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank())
```

![](Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

Time bands are the range of times (in months) for patients to be seen in Irish public hospitals. There is a lot of adult patients in all time bands compared to child patients. Looking at Figure 9, 0 to 3 months has the highest number of patients and 15 to 18 months has the least number of patients.

There are less number of patients as waiting time (time bands) gets longer, but there is a slight increase in total cases for time band 18+ months. It could be inferred from Figure 24 that all hospitals are trying to see as many patients in the waiting list as soon as possible.

A patient in the time band of 0 to 3 month are scheduled to be seen within 3 months from November 2017. It is also important to note that when a patient is being put in a waiting list, many aspects have been considered especially the severity of the disease. As an example, a patient with hyperkalaemia will always be seen and treated immediately.

``` r
# Total Cases by Time Bands based on Case Type in Nov 2017
wl_nov %>% group_by(Time.Bands, Case.Type) %>%
  summarise(Total_Cases = sum(Total)) %>%
  ggplot(aes(Time.Bands, Total_Cases, fill = Case.Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = Total_Cases), size = 3, position = position_dodge(0.9),
            vjust = 1.1, color = "white") +
  labs(title = "Total Cases by Time Bands based on Case Type in Nov 2017",
       x = "Time Bands",
       y = "Total Cases") +
  scale_fill_discrete(name = "Case Type") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank())
```

![](Project_2_-_Waiting_List_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

From the figure above, it can be seen that across all time bands, there is a lot more patient with day case than inpatient case in the waiting list.

Recommendations
===============

From this series of analyses, it is obvious that a big portion of cases in the waiting list are day cases. Strategies should be developed to allow patients to be seen quicker. More resources should be allocated to alleviate this problem.

The top five hospitals with the highest number of patients in the waiting list are Galway University Hospital, Beaumont Hospital, Mater Misericordiae University Hospital, University Hospital Waterford and St. James’s Hospital.

Based on specialties, the top five specialties with the highest number of patients in the waiting list are Orthopaedics, Ophthalmology, Urology, General Surgery and Otolaryngology (ENT). These hospitals and specialties will need special attention to deal with their waiting list. Further data and analysis are required to determine the factors causing this backlog in these specialties.

Conclusion
==========

The data analyses has provided some valuable information regarding the waiting list in Ireland. Most cases in the waiting list are day cases and the top five hospitals and specialties with the highest number of patients in the waiting list are now recognised and recommendations are made accordingly. Regarding the figures used in Irish Times and RTE, a small conclusion can be made that the numbers are misleading due to the way aggregated data were processed.
