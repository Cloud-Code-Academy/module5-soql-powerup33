/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Michelle Holman
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    
    public static List<Lead> getAllLeads() {
        List<Lead> leads = [
            SELECT Id, LastName, Company, Phone, Email 
            FROM Lead
            ];
        return leads;
    }       //PASS

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    
    public static List<Contact> getContactsByFirstName() {
        // Query both FirstName and Name fields
        return [
            SELECT Id, FirstName, Name, LastName 
            FROM Contact 
            WHERE FirstName = 'John'
            ];
    }       //PASS

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName() {
        List<Contact> contacts = [
            SELECT Id 
            FROM Contact 
            WHERE LastName 
            IN ('Smith', 'Jones')
            ];

        List<Id> contactIds = new List<Id>();
        for (Contact con : contacts) {
            contactIds.add(con.Id);
        }
        
        return contactIds;
    }       //PASS


    /**
     * Question 4
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */    

    public static List<Opportunity> getClosedWonOpportunitiesByAccount(Id accountId) {
        List<Opportunity> closedWonOpps = [
            SELECT Id, Name, StageName, AccountId, CloseDate, Amount
            FROM Opportunity
            WHERE AccountId = :accountId 
            AND StageName = 'Closed Won'
            ];
        return closedWonOpps;
    }      //PASS        
        

    /**
     * Question 5
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount() {
        // Query for the count of Account records
        Integer myAccountCount = [
            SELECT COUNT() 
            FROM Account
            ];
        return myAccountCount;
    }       //PASS


    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
        
    public static Map<Id, Task> getTasksDueInNextSevenDays() {
        // Query for tasks due within the next 7 days
        Date nextWeek = Date.today().addDays(7);
        Date today = Date.today();
    
        // Create a map to store Task Ids to Task records
        Map<Id, Task> taskMap = new Map<Id, Task>();
    
        // Query for tasks due within the next 7 days
        for(Task t : [
            SELECT Id, Subject, ActivityDate 
            FROM Task 
            WHERE ActivityDate >= :today 
            AND ActivityDate <= :nextWeek
            ]) {
            taskMap.put(t.Id, t);
        }
    
        return taskMap;
    }       //PASS
    

    /**
     * Question 7
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsWithEmailDomain() {
        // Query for contacts with email addresses containing the example.com domain
        List<Contact> contactEmail = [
            SELECT Id, Name, Email 
            FROM Contact 
            WHERE Email 
            LIKE '%@example.com'
            ];
        
        return contactEmail;
    }       //PASS

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        // Initialize a list to store the results
        List<Opportunity> opportunities = new List<Opportunity>();
            
         // Query opportunities with the specified keyword in their Name field
        opportunities = [
            SELECT Id, Name 
            FROM Opportunity 
            WHERE Name 
            LIKE :('%' + keyword + '%')
            ];
            
        // Return the list of opportunities
        return opportunities;
    }       //PASS


    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        // Initialize a list to store the results
        List<Case> filteredCases = new List<Case>();

        //Perform SOQL query to retrieve Case records we want
        List<Case> cases = [
            SELECT Id, Status, Origin 
            FROM Case 
            WHERE Origin 
            NOT IN ('Web', 'Email', '')
            ];
        for (Case c : cases) {
            filteredCases.add(c);
        }
        return filteredCases;
    }       //PASS

    /**
     * Question 10
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
        // Initialize a list to store the results
        List<Lead> filteredLeads = new List<Lead>();

        // Query for leads that match the specified Lead Source or contain the specified keyword in their Title
        String keywordPattern = '%' + keyword + '%';
        filteredLeads = [
            SELECT Id, LastName, Company, Phone, Email, LeadSource, Title 
            FROM Lead 
            WHERE (LeadSource = :leadSource OR Title LIKE :keywordPattern) 
            ];
        
        // Return the list of filtered leads
        return filteredLeads;
    }       //PASS
    
    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Initialize a list to store the results
        List<String> contactLastNames = new List<String>();
        // SOQL query to retrieve Contact LastNames
        for(Contact c : [
            SELECT LastName 
            FROM Contact 
            WHERE AccountId = :accountId
            ]) {
            contactLastNames.add(c.LastName);
        }        
        // Return the list of Contact LastNames
        return contactLastNames;
    }       //PASS

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Initialize a variable to store the total revenue
        Decimal totalRevenue;
        
        // Use AggregateQuery to get the total revenue
        AggregateResult[] results = [
            SELECT SUM(Amount) totalAmount 
            FROM Opportunity 
            WHERE (StageName = :stage 
            OR Amount > 10000)
            ];
        
        // Retrieve the total amount from the AggregateResult
        totalRevenue = (Decimal)results[0].get('totalAmount');
        
        // Return the total revenue
        return totalRevenue;
    }       //PASS

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        // Query for the first 10 Accounts ordered by Name
        List<Account> firstTenAccts = [
            SELECT Id, Name
            FROM Account
            ORDER BY Name
            LIMIT 10
            ];
        
         // Return the list of the first 10 Accounts
        return firstTenAccts;
        }       //PASS
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        // Opportunities w Amount > 100,000, ordered by CloseDate, limit 5
        List<Opportunity> highValueOpportunities = [
            SELECT Id, Name, CloseDate, Amount
            FROM Opportunity
            WHERE Amount > 100000
            ORDER BY CloseDate
            LIMIT 5
            ];
        
        // Return list of high value Opportunities
        return highValueOpportunities;
    }       //PASS
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        // Contacts with the most recent Birthdate, ordered by Birthdate, limit 3
        List<Contact> bDayContacts = [
            SELECT Id, FirstName, LastName, Birthdate
            FROM Contact
            ORDER BY Birthdate DESC
            LIMIT 3
            ];
        
        // Return the list of contacts
        return bDayContacts;
    }       //PASS

    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        return [SELECT Id, Subject, Status, CreatedDate 
                FROM Case 
                WHERE Status = 'Open' 
                ORDER BY CreatedDate 
                LIMIT 10 OFFSET 5
                ];
    }


    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Case IDs associated with the given Account
        List<Case> cases = [
            SELECT Id
            FROM Case
            WHERE AccountId = :accountId
            ];
        // set to store the Case IDs
        Set<Id> caseIds = new Set<Id>();
            
        // Add Case IDs to the set
        for (Case c : cases) {
            caseIds.add(c.Id);
        }
        // Return the set of Case IDs
        return caseIds;
    }       //PASS

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        
        // Query the Accounts not in the specified country
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            WHERE BillingCountry != :country
            ];
        // Loop through each Account and add the Id and Name to the map
        for (Account acc : accounts) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }
        // Return map
        return accountIdsToNames;
    }       //PASS


    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        String accountName = [
            SELECT Account.Name 
            FROM Contact 
            WHERE Id = :contactId 
            LIMIT 1
            ].Account.Name;
        return accountName;
    }       //PASS

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        // Query the Account and its related Opportunities
        Account accWithOpportunities = [
            SELECT Id, Name, (SELECT Id, Name 
                                FROM Opportunities) 
            FROM Account 
            WHERE Id = :accountId
            ];
        return accWithOpportunities;
    }       //PASS


    /**
     * Question 21
c     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account to retrieve its BillingState
        Account acc = [
            SELECT BillingState 
            FROM Account 
            WHERE Id = :accountId LIMIT 1
            ];
        // Store the Account's BillingState
        String billingState = acc.BillingState;
            
        // Query the Contacts with Mailing State matching the Account's Billing State
        List<Contact> contacts = [
            SELECT Id, Name, MailingState 
            FROM Contact 
            WHERE MailingState = :billingState
            ];
            
        return contacts;
    }       //PASS


    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Step 1: Query the Leads to extract email domains
        List<Lead> leads = [
            SELECT Id, Email 
            FROM Lead 
            WHERE Id 
            IN :leadIds
            ];
        
        // Set to hold email domains from Leads
        Set<String> emailDomains = new Set<String>();
        
        // Step 2: Extract email domains from Lead emails
        for (Lead lead : leads) {
            String leadEmail = lead.Email;
            if (leadEmail != null && leadEmail.contains('@')) {
                List<String> emailParts = leadEmail.split('@');
                if (emailParts.size() == 2) {
                    emailDomains.add(emailParts[1]);
                }
            }
        }
        
        // Step 3: Query the Accounts with matching website domains
        List<Account> matchingAccounts = [
            SELECT Id, Website 
            FROM Account 
            WHERE Website 
            IN :emailDomains
            ];
        
        return matchingAccounts;
    }       //PASS
        
        

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     * 
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> origLineItems = [
            SELECT Id, Quantity, UnitPrice, PricebookEntryId 
            FROM OpportunityLineItem 
            WHERE OpportunityId = :origOppId
            ];
        
        // List to hold new line items
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        
        // Loop through each cloned Opportunity Id
        for (Id cloneOppId : cloneOppIds) {
            // Loop through each original line item
            for (OpportunityLineItem origLineItem : origLineItems) {
                // Clone the original line item
                OpportunityLineItem newLineItem = origLineItem.clone();
                newLineItem.OpportunityId = cloneOppId;
        
                // Add a randomized number between 1 to 3 to the quantity
                Integer randomQuantity = (Integer)Math.floor(Math.random() * 3) + 1;
                newLineItem.Quantity += randomQuantity;
        
                // Add the new line item to the list
                newLineItems.add(newLineItem);
            }
        }
        
        // Insert the new line items
        insert newLineItems;
    }       //PASS
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() { 
        // Perform a SOQL query to retrieve Opportunity records with StageName = 'Closed Won'
        List<Opportunity> closedWonOpps = [
            SELECT Id, Name, AccountId, OwnerId 
            FROM Opportunity 
            WHERE StageName = 'Closed Won'
            ];
        return closedWonOpps;
    }       //PASS

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        // Retrieve Closed Won Opportunities
        List<Opportunity> opportunities = getOpportunityDetailsForClosedWon();
        
        // Loop through each Opportunity and update the Primary Contact
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        for (Opportunity opp : opportunities) {
            // Query the first Contact related to the Account
            Contact firstContact = [
                SELECT Id 
                FROM Contact 
                WHERE AccountId = :opp.AccountId 
                ORDER BY CreatedDate ASC LIMIT 1
                ];
                // Check if a Contact is found
            if (firstContact != null) {
                // Set the Primary Contact to the first Contact related to the Account
                opp.Primary_Contact__c = firstContact.Id;
                opportunitiesToUpdate.add(opp);
            }
        }
        
        // Update the Opportunities
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }       //PASS
 
}        