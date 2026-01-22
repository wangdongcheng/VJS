# Sample Acumatica Import Scenario (Access Rights) - AugForums.com
https://www.augforums.com/sample-acumatica-import-scenario-access-rights/

**Here is an Access Rights sample Acumatica Import Scenario with Installation Instructions.**

![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/f9f72597-9846-45bb-91bb-59be2e702889.png?raw=true)

**[Click here for a listing of other Sample Acumatica Import Scenarios](https://www.augforums.com/sample-acumatica-import-scenarios)**

[**Click here for an updated Excel file that allows you to easily build security groups in Excel, then import them using the method outlined below**](https://www.augforums.com/forums/everything-else/importing-acumatica-user-roles-user-security-permissions-from-excel/)

**Screen:** CONFIGURATION -> User Security -> Work Area -> MANAGE -> Access Rights by Screen (SM201020)

**Fields Imported**

1.  Site Map Path
2.  Role
3.  Access Rights

**Files**

*   **[Access Rights Data Provider.xlsx](https://timrodman.s3.us-east-2.amazonaws.com/wp-content/uploads/2018/02/04154418/Access-Rights-Data-Provider.xlsx)** (contains a few rows of sample data from the SalesDemo company)
*   **[0 Access Rights Data Provider.xml](https://timrodman.s3.us-east-2.amazonaws.com/wp-content/uploads/2018/02/04154434/0-Access-Rights-Data-Provider.xml)**
*   **[0 Access Rights Import Scenario.xml](https://timrodman.s3.us-east-2.amazonaws.com/wp-content/uploads/2018/02/04154440/0-Access-Rights-Import-Scenario.xml)**

**Installation Instructions**

1.  On the SYSTEM -> Integration -> MANAGE -> Data Providers (SM206015) screen,  
    import the 0 Access Rights Data Provider.xml file  
    using the Import from XML option on the paperclip icon pictured below![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/d2381f1a-d41d-4b92-9d9b-c360be55db88.png?raw=true)
    
2.  The Schema tab should now look like this  
    ![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/1b37c122-803e-4728-8074-7558e971ed96.png?raw=true)
    
3.  Upload the Access Rights Data Provider.xlsx file using the FILES, BROWSE and UPLOAD buttons in the upper right-hand corner of the screen![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/e985947a-77b9-4eb5-b680-c6eadf87c127.png?raw=true)
    
4.  On the SYSTEM -> Integration -> MANAGE -> Import Scenarios (SM206025) screen,  
    import the 0 Customers Import Scenario.xml file  
    using the Import from XML option on the paperclip icon pictured below![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/3136ebab-0ee3-4b70-9d34-447530f75ec1.png?raw=true)
    
5.  Your screen should now look like the screenshot on the top of this post
6.  On the SYSTEM -> Integration -> PROCESS -> Import by Scenario (SM206036) screen,  
    select 0 Access Rights Import Scenario and click the PREPARE button  
    ![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/7975d076-bab8-4bba-b02b-b8f065e20486.png?raw=true)
    
7.  Acumatica will bring the data from the Excel file into the grid on the Prepared Data tab. You know it’s finished when you get the green checkmark on the top of the screen.  
    ![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/44a698be-596e-470d-8c54-b270679a6101.png?raw=true)
    
8.  From this point forward, Acumatica will be using the data in the grid on the Prepared Data tab to do the import. It doesn’t go back and “talk” to Excel. So, you can change the data in the grid if you want and this will be the data that gets used for the import.
9.  Now we need to actually do the import. Before you do this, I recommend taking a Snapshot backup of Acumatica so you’ll have something to roll back to if you don’t like the results.
10.  Also, note that only the records that have Active checked and Processed unchecked will be imported. The other ones will be ignored by the import.
11.  To import, click the IMPORT button![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/8eac7509-00ee-4cd7-abc1-1f20d29f72a8.png?raw=true)
    
12.  When it’s finished, you’ll get a green checkmark on the top of the screen if there were no errors and the Processed column will be checked for all records that imported successfully.  
    ![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/61f56792-4403-4bc9-81a5-f7161ae7e343.png?raw=true)
    
13.  If you get a red checkmark on the top of the screen, it means that you got an error on one of the records. Just look for the record that has a message in the Error column. You can hover over the message to see the full error message.![](https://github.com/wangdongcheng/GitNotebook/blob/main/img/imghost/18-11-2025,%2009-51-26/915ca970-cb1c-4e03-96ac-7275ff58103b.png?raw=true)
    

**Note: If you have any issues with using this sample import scenario, please leave a comment on this [Discussion Topic (click here)](https://www.augforums.com/augforums/acumatica-import-scenarios/acumatica-import-scenario-access-rights-by-role).**