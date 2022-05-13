/*  File:    bankLoan.pl
    Purpose: Does the loan should be granted by the bank.
*/

%client_facts
male(bob).
male(toto).
male(sam).

age(bob, 35).
age(toto, 29).
age(lena, 76).
age(sam, 21).

student(sam).

monthlyIncome(bob, 1390).
monthlyIncome(toto, 1630).
monthlyIncome(lena, 2430).
monthlyIncome(sam, 720).

monthlyFees(bob, 760).
monthlyFees(toto, 690).
monthlyFees(lena, 1690).
monthlyFees(sam, 430).

blackList(toto).

%credit_facts
amount(cred1, 20000).
amount(cred2, 1500).

duration(cred1, 120).
duration(cred2, 12).

rate(cred1, 0.08).
rate(cred2, 0.7).

%rules
lifeExpectancy(Person, E) :-
  male(Person) -> E = 68;
  E = 73.

creditRate(Credit, Person, R) :-
  student(Person) -> R = 0;
  rate(Credit, CR),
  R = CR.

monthlyDept(Credit, Person, M) :-
  amount(Credit, A),
  creditRate(Credit, Person, R),
  duration(Credit, D),
  M = ((A*R) + A)/D.

financialSituation(I, F, D) :-
  (I - F) > D.

ageVerif(Person, Credit) :-
  lifeExpectancy(Person, E),
  age(Person, A),
  duration(Credit, D),
  E > (A + (D/12)).

loan(Client, Credit) :-
  not(blackList(Client)),

  monthlyDept(Credit, Client, D),
  monthlyIncome(Client, I),
  monthlyFees(Client, F),
  
  financialSituation(I, F, D),
  ageVerif(Client, Credit).
