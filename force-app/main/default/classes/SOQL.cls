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
    }
               //PASS        
        

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
    }       //Passes debug, not test class


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
    }       //Passes in ChatGPT
    

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsWithEmailDomain() {
        // Query for contacts with email addresses containing the example.com domain
        List<Contact> contactEmail = [SELECT Id, Name, Email FROM Contact WHERE Email LIKE '%@example.com'];
        
        return contactEmail;
    }

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
        //opportunities = [SELECT Id, Name 
                        //FROM Opportunity 
                        //WHERE Name 
                        //LIKE :('%' + keyword + '%')];
        
            // Return the list of opportunities
            return opportunities;
        }       //PASS
        


    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> filteredCases = new List<Case>();
        List<Case> cases = [SELECT Id, Status, Origin FROM Case WHERE Origin NOT
        IN ('Web', 'Email', 'Blank')];
        for (Case c : cases) {
            filteredCases.add(c);
        }
        return filteredCases;
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
        // Query for leads that match the specified Lead Source or contain the specified keyword in their Title
        String keywordPattern = '%' + keyword + '%';
        List<Lead> leads = [SELECT Id, LastName, Company, Phone, Email, LeadSource, Title 
                            FROM Lead 
                            WHERE (LeadSource = :leadSource OR Title LIKE :keywordPattern) 
                            AND LastName != null];
                return leads;
    }
    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
            List<String> contactLastNames = new List<String>();
        
            // Construct dynamic SOQL query to retrieve Contact LastNames
            String query = 'SELECT LastName FROM Contact WHERE AccountId = :accountId';
            List<Contact> contacts = Database.query(query);
        
            // Extract last names and add them to the list
            for (Contact con : contacts) {
                contactLastNames.add(con.LastName);
            }
        
            // Return the list of Contact LastNames
            return contactLastNames;
        }
        
        // Create a list to hold the Contact LastNames

        // Query the Contacts
        // Loop through each Contact and add the LastName to the list
        //for () {
        //    
        //}

        // Return the list of Contact LastNames
        //return null; // Replace null with the variable you used to store the result
    //}

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue

        // Return the total revenue
        return null; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return null; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        return null; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        return null; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        return null; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids

        // Query the Cases
        // Loop through each Case and add the Id to the set
        //for () {
        //    
        //}

        return null; // Replace null with the variable you used to store the result
    }

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

        // Query the Accounts
        // Loop through each Account and add the Id and Name to the map

        return null; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        return null; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        // Query the Account and its related Opportunities
        Account accWithOpportunities = [SELECT Id, Name, (SELECT Id, Name 
                                                            FROM Opportunities) 
                                        FROM Account 
                                        WHERE Id = :accountId];
            
            return accWithOpportunities;
        }


    /**
     * Question 21
c     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account to retrieve its BillingState
        Account acc = [SELECT BillingState 
                        FROM Account 
                        WHERE Id = :accountId LIMIT 1];
            
        // Store the Account's BillingState
        String billingState = acc.BillingState;
            
        // Query the Contacts with Mailing State matching the Account's Billing State
        List<Contact> contacts = [SELECT Id, Name, MailingState 
                                    FROM Contact 
                                    WHERE MailingState = :billingState];
            
        return contacts;
    }


    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads

        // Create a set of email domains from the Leads

        // Loop through each Lead

            // Get the email from the Lead

            // Check if the email is not null

                // Add the email domain to the set

        
        // Query the Accounts
        return null; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items

        // Create a list to hold the new line items

        // Generate a random number between 1 and 3

        // Loop through each cloned Opportunity Id

            // Loop through each original line item

                // Clone the original line item and add the random number to the quantity

        // Insert the new line items
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() { 
        // Perform a SOQL query to retrieve Opportunity records with StageName = 'Closed Won'
        List<Opportunity> opportunities = [SELECT Id, Name, AccountId, OwnerId 
                                            FROM Opportunity 
                                            WHERE StageName = 'Closed Won'];
            return opportunities;
            }       //works in debug

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        // Use the getOpportunityDetailsForClosed
        List<Opportunity> opportunities = getOpportunityDetailsForClosedWon();
        
        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : opportunities) {
            accountIds.add(opp.AccountId);
        
        // Query the Contacts related to the Accounts
        Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
            for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds ORDER BY CreatedDate ASC]) {
                if (!accountToContactMap.containsKey(con.AccountId)) {
                    accountToContactMap.put(con.AccountId, con);
                }
            }
        
        // Loop through each Opportunity and update the primary contact from accountToContactMap
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
            for (Opportunity opport : opportunities) {
                Contact primaryContact = accountToContactMap.get(opp.AccountId);
                if (primaryContact != null) {
                    opp.Primary_Contact__c = primaryContact.Id;
                    opportunitiesToUpdate.add(opp);
                }
            }
        
        // Update the Opportunities
            if (!opportunitiesToUpdate.isEmpty()) {
                update opportunitiesToUpdate;
            }
        }
        
        
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities

        // Create a set of Account Ids from the Opportunities

        // Query the Contacts

        // Loop through each Contact and add the Account Id and Contact to the map
        
        // Loop through each Opportunity

                // Update the Opportunity primary contact from accountToContactMap

        // Update the Opportunities
    
    }
}