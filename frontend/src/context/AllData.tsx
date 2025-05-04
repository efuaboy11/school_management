import { createContext, useContext, useEffect, useState } from "react";
import AuthContext from "./AuthContext";
import { ReactNode } from "react";

interface AllDataContextTye{

  //Student
  studentCount: number
  setStudentCount: (count: number) => void
  recentStudent: any[]
  setRecentStudent: (student: any[]) => void
  studentData: any[]
  setStudentData:(data: any[]) => void
  studentLoader: boolean
  setStudentLoader: (loader: boolean) => void
  studentSearch: string
  setStudentSearch: (loader: string) => void

  // Staff
  staffCount: number
  setStaffCount: (count: number) => void
  recentStaff: any[]
  setRecentStaff: (data: any[]) => void
  staffData: any[]
  setStaffData:(data: any[]) => void
  staffLoader: boolean
  setStaffLoader: (loader: boolean) => void
  staffSearch: string
  setStaffSearch: (loader: string) => void


  //hr
  hrCount: number
  setHrCount: (count: number) => void
  hrData: any[]
  setHrData:(data: any[]) => void
  hrLoader: boolean
  setHrLoader: (loader: boolean) => void
  hrSearch: string
  setHrSearch: (loader: string) => void

  // bursary
  bursaryCount: number
  setBursaryCount: (count: number) => void
  bursaryData: any[]
  setBursaryData:(data: any[]) => void
  bursaryLoader: boolean
  setBursaryLoader: (loader: boolean) => void
  bursarySearch: string
  setBursarySearch: (loader: string) => void

  // store Keeper
  storeKeeperCount: number
  setStoreKeeperCount: (count: number) => void
  storeKeeperData: any[]
  setStoreKeeperData:(data: any[]) => void
  storeKeeperLoader: boolean
  setStoreKeeperLoader: (loader: boolean) => void
  storeKeeperSearch: string
  setStoreKeeperSearch: (loader: string) => void

  // exam officer
  examOfficerCount: number
  setExamOfficerCount: (count: number) => void
  examOfficerData: any[]
  setExamOfficerData:(data: any[]) => void
  examOfficerLoader: boolean
  setExamOfficerLoader: (loader: boolean) => void
  examOfficerSearch: string
  setExamOfficerSearch: (loader: string) => void
 
  // academic officer
  academicOfficerCount: number
  setAcademicOfficerCount: (count: number) => void
  academicOfficerData: any[]
  setAcademicOfficerData:(data: any[]) => void
  academicOfficerLoader: boolean
  setAcademicOfficerLoader: (loader: boolean) => void
  academicOfficerSearch: string
  setAcademicOfficerSearch: (loader: string) => void


  // other Staff
  otherStaffCount: number
  setOtherStaffCount: (count: number) => void
  otherStaffData: any[]
  setOtherStaffData:(data: any[]) => void
  otherStaffLoader: boolean
  setOtherStaffLoader: (loader: boolean) => void
  otherStaffSearch: string
  setOtherStaffSearch: (loader: string) => void

  // email
  emailCount: number
  setEmailCount: (count: number) => void
  recentEmail: any[]
  setRecentEmail: (data: any[]) => void
  emailData: any[]
  setEmailData:(data: any[]) => void
  emailLoader: boolean
  setEmailLoader: (loader: boolean) => void
  emailSearch: string
  setEmailSearch: (loader: string) => void


  // subject
  subjectCount: number
  setSubjectCount: (count: number) => void
  recentSubject: any[]
  setRecentSubject: (data: any[]) => void
  subjectData: any[]
  setSubjectData:(data: any[]) => void
  subjectLoader: boolean
  setSubjectLoader: (loader: boolean) => void
  subjectSearch: string
  setSubjectSearch: (loader: string) => void

  termCount: number
  setTermCount: (count: number) => void
  termData: any[]
  setTermData:(data: any[]) => void
  termLoader: boolean
  setTermLoader: (loader: boolean) => void
  termSearch: string
  setTermSearch: (loader: string) => void

  // session
  sessionCount: number
  setSessionCount: (count: number) => void
  currentsession: any[]
  setCurentSession: (data: any[]) => void
  sessionData: any[]
  setSessionData:(data: any[]) => void
  sessionLoader: boolean
  setSessionLoader: (loader: boolean) => void
  sessionSearch: string
  setSessionSearch: (loader: string) => void

  // admin or hr notifcation
  adminHrNotificationCount: number
  setAdminHrNotificationCount: (count: number) => void
  recentAdminHrNotification: any[]
  setRecentAdminHrNotification: (data: any[]) => void
  adminHrNotificationData: any[]
  setAdminHrNotificationData:(data: any[]) => void
  adminHrNotificationLoader: boolean
  setAdminHrNotificationLoader: (loader: boolean) => void
  adminHrNotificationSearch: string
  setAdminHrNotificationSearch: (loader: string) => void

  // school notification
  schoolNotificationCount: number
  setSchoolNotificationCount: (count: number) => void
  recentSchoolNotification: any[]
  setRecentSchoolNotification: (data: any[]) => void
  schoolNotificationData: any[]
  setSchoolNotificationData:(data: any[]) => void
  schoolNotificationLoader: boolean
  setSchoolNotificationLoader: (loader: boolean) => void
  schoolNotificationSearch: string
  setSchoolNotificationSearch: (loader: string) => void

  // class notification
  classNotificationCount: number
  setClassNotificationCount: (count: number) => void
  recentClassNotification: any[]
  setRecentClassNotification: (data: any[]) => void
  classNotificationData: any[]
  setClassNotificationData:(data: any[]) => void
  classNotificationLoader: boolean
  setClassNotificationLoader: (loader: boolean) => void
  classNotificationSearch: string
  setClassNotificationSearch: (loader: string) => void


  // staff notification
  staffNotificationCount: number
  setStaffNotificationCount: (count: number) => void
  recentStaffNotification: any[]
  setRecentStaffNotification: (data: any[]) => void
  staffNotificationData: any[]
  setStaffNotificationData:(data: any[]) => void
  staffNotificationLoader: boolean
  setStaffNotificationLoader: (loader: boolean) => void
  staffNotificationSearch: string
  setStaffNotificationSearch: (loader: string) => void

  // school event
  schoolEventCount: number
  setSchoolEventCount: (count: number) => void
  recentSchoolEvent: any[]
  setRecentSchoolEvent: (data: any[]) => void
  schoolEventData: any[]
  setSchoolEventData:(data: any[]) => void
  schoolEventLoader: boolean
  setSchoolEventLoader: (loader: boolean) => void
  schoolEventSearch: string
  setSchoolEventSearch: (loader: string) => void


  // asignment
  assignmentCount: number
  setAssignmentCount: (count: number) => void
  recentAssignment: any[]
  setRecentAssignment: (data: any[]) => void
  assignmentData: any[]
  setAssignmentData:(data: any[]) => void
  assignmentLoader: boolean
  setAssignmentLoader: (loader: boolean) => void
  assignmentSearch: string
  setAssignmentSearch: (loader: string) => void

  // assignment Submission
  assignmentSubmissionCount: number
  setAssignmentSubmissionCount: (count: number) => void
  recentAssignmentSubmission: any[]
  setRecentAssignmentSubmission: (data: any[]) => void
  assignmentSubmissionData: any[]
  setAssignmentSubmissionData:(data: any[]) => void
  assignmentSubmissionLoader: boolean
  setAssignmentSubmissionLoader: (loader: boolean) => void
  assignmentSubmissionSearch: string
  setAssignmentSubmissionSearch: (loader: string) => void

  // class Timetable
  classTimetableCount: number
  setClassTimetableCount: (count: number) => void
  recentClassTimetable: any[]
  setRecentClassTimetable: (data: any[]) => void
  classTimetableData: any[]
  setClassTimetableData:(data: any[]) => void
  classTimetableLoader: boolean
  setClassTimetableLoader: (loader: boolean) => void
  classTimetableSearch: string
  setClassTimetableSearch: (loader: string) => void

  // payment Method
  paymentMethodCount: number
  setPaymentMethodCount: (count: number) => void
  paymentMethodData: any[]
  setPaymentMethodData:(data: any[]) => void
  paymentMethodLoader: boolean
  setPaymentMethodLoader: (loader: boolean) => void
  paymentMethodSearch: string
  setPaymentMethodSearch: (loader: string) => void
 

  // school Fees
  schoolFeesCount: number
  setSchoolFeesCount: (count: number) => void
  schoolFeesData: any[]
  setSchoolFeesData:(data: any[]) => void
  schoolFeesLoader: boolean
  setSchoolFeesLoader: (loader: boolean) => void
  schoolFeesSearch: string
  setSchoolFeesSearch: (loader: string) => void

  // all school fees payment
  allSchoolFeesPaymentCount: number
  setAllSchoolFeesPaymentCount: (count: number) => void
  recentAllSchoolFeesPayment: any[]
  setRecentAllSchoolFeesPayment: (data: any[]) => void
  allSchoolFeesPaymentData: any[]
  setAllSchoolFeesPaymentData:(data: any[]) => void
  allSchoolFeesPaymentLoader: boolean
  setAllSchoolFeesPaymentLoader: (loader: boolean) => void
  allSchoolFeesPaymentSearch: string
  setAllSchoolFeesPaymentSearch: (loader: string) => void


  // pending school fees payment
  pendingSchoolFeesPaymentCount: number
  setPendingSchoolFeesPaymentCount: (count: number) => void
  recentPendingSchoolFeesPayment: any[]
  setRecentPendingSchoolFeesPayment: (data: any[]) => void
  pendingSchoolFeesPaymentData: any[]
  setPendingSchoolFeesPaymentData:(data: any[]) => void
  pendingSchoolFeesPaymentLoader: boolean
  setPendingSchoolFeesPaymentLoader: (loader: boolean) => void
  pendingSchoolFeesPaymentSearch: string
  setPendingSchoolFeesPaymentSearch: (loader: string) => void

  // sucess school fees payment
  sucessSchoolFeesPaymentCount: number
  setSucessSchoolFeesPaymentCount: (count: number) => void
  recentSucessSchoolFeesPayment: any[]
  setRecentSucessSchoolFeesPayment: (data: any[]) => void
  sucessSchoolFeesPaymentData: any[]
  setSucessSchoolFeesPaymentData:(data: any[]) => void
  sucessSchoolFeesPaymentLoader: boolean
  setSucessSchoolFeesPaymentLoader: (loader: boolean) => void
  sucessSchoolFeesPaymentSearch: string
  setSucessSchoolFeesPaymentSearch: (loader: string) => void

  // declined school fees payment
  declinedSchoolFeesPaymentCount: number
  setDeclinedSchoolFeesPaymentCount: (count: number) => void
  recentDeclinedSchoolFeesPayment: any[]
  setRecentDeclinedSchoolFeesPayment: (data: any[]) => void
  declinedSchoolFeesPaymentData: any[]
  setDeclinedSchoolFeesPaymentData:(data: any[]) => void
  declinedSchoolFeesPaymentLoader: boolean
  setDeclinedSchoolFeesPaymentLoader: (loader: boolean) => void
  declinedSchoolFeesPaymentSearch: string
  setDeclinedSchoolFeesPaymentSearch: (loader: string) => void


  // bills
  billsCount: number
  setBillsCount: (count: number) => void
  recentBills: any[]
  setRecentBills: (data: any[]) => void
  billsData: any[]
  setBillsData:(data: any[]) => void
  billsLoader: boolean
  setBillsLoader: (loader: boolean) => void
  billsSearch: string
  setBillsSearch: (loader: string) => void

  // pending bills
  pendingBillsCount: number
  setPendingBillsCount: (count: number) => void
  recentPendingBills: any[]
  setRecentPendingBills: (data: any[]) => void
  pendingBillsData: any[]
  setPendingBillsData:(data: any[]) => void
  pendingBillsLoader: boolean
  setPendingBillsLoader: (loader: boolean) => void
  pendingBillsSearch: string
  setPendingBillsSearch: (loader: string) => void

  // sucess bills
  sucessBillsCount: number
  setSucessBillsCount: (count: number) => void
  recentSucessBills: any[]
  setRecentSucessBills: (data: any[]) => void
  sucessBillsData: any[]
  setSucessBillsData:(data: any[]) => void
  sucessBillsLoader: boolean
  setSucessBillsLoader: (loader: boolean) => void
  sucessBillsSearch: string
  setSucessBillsSearch: (loader: string) => void

  // declned bills
  declinedBillsCount: number
  setDeclinedBillsCount: (count: number) => void
  recentDeclinedBills: any[]
  setRecentDeclinedBills: (data: any[]) => void
  declinedBillsData: any[]
  setDeclinedBillsData:(data: any[]) => void
  declinedBillsLoader: boolean
  setDeclinedBillsLoader: (loader: boolean) => void
  declinedBillsSearch: string
  setDeclinedBillsSearch: (loader: string) => void

  // product categories
  productCatergoriesCount: number
  setProductCatergoriesCount: (count: number) => void
  productCatergoriesData: any[]
  setProductCatergoriesData:(data: any[]) => void
  productCatergoriesLoader: boolean
  setProductCatergoriesLoader: (loader: boolean) => void
  productCatergoriesSearch: string
  setProductCatergoriesSearch: (loader: string) => void


  //product
  productCount: number
  setProductCount: (count: number) => void
  recentProduct: any[]
  setRecentProduct: (data: any[]) => void
  productData: any[]
  setProductData:(data: any[]) => void
  productLoader: boolean
  setProductLoader: (loader: boolean) => void
  productSearch: string
  setProductSearch: (loader: string) => void

  // favourite product
  favouriteProductCount: number
  setFavouriteProductCount: (count: number) => void
  recentFavouriteProduct: any[]
  setRecentFavouriteProduct: (data: any[]) => void
  favouriteProductData: any[]
  setFavouriteProductData:(data: any[]) => void
  favouriteProductLoader: boolean
  setFavouriteProductLoader: (loader: boolean) => void
  favouriteProductSearch: string
  setFavouriteProductSearch: (loader: string) => void


  // order product
  orderProductCount: number
  setOrderProductCount: (count: number) => void
  recentOrderProduct: any[]
  setRecentOrderProduct: (data: any[]) => void
  orderProductData: any[]
  setOrderProductData:(data: any[]) => void
  orderProductLoader: boolean
  setOrderProductLoader: (loader: boolean) => void
  orderProductSearch: string
  setOrderProductSearch: (loader: string) => void

  // --------------------------------------- Function -------------------------------

  // student
  StudentFunction: () => Promise<void>;
  FilterStudent: () => Promise<void>;

  // staff
  StaffFunction: () => Promise<void>;
  FilterStaff: () => Promise<void>;

  // Hr
  HrFunction: () => Promise<void>;
  FilterHr: () => Promise<void>;

  // Bursary
  BursaryFunction: () => Promise<void>;
  FilterBursary: () => Promise<void>;

  //store keeper #
  StoreKeeperFunction: () => Promise<void>;
  FilterStoreKeeper: () => Promise<void>;

  // exam officer
  ExamOfficerFunction: () => Promise<void>;
  FilterExamOfficer: () => Promise<void>;

  // academic officer
  AcademicOfficerFunction: () => Promise<void>;
  FilterAcademicOfficer: () => Promise<void>;

  // other staff
  OtherStaffFunction: () => Promise<void>;
  FilterOtherStaff: () => Promise<void>;

  // email
  EmailFunction: () => Promise<void>;
  FilterEmail: () => Promise<void>;

  //subject
  SubjectFunction: () => Promise<void>;
  FilterSubject: () => Promise<void>;

  // Terms
  TermFunction: () => Promise<void>;
  FilterTerm: () => Promise<void>;

  // Session
  SessionFunction: () => Promise<void>;
  FilterSession: () => Promise<void>;

  // Admin or hr Notification
  AdminHrNotificationFunction: () => Promise<void>;
  FilteradminHrNotification: () => Promise<void>;

  // School Notification
  SchoolNotificationFunction: () => Promise<void>;
  FilterSchoolNotification: () => Promise<void>;

  // class Notification
  ClassNotificationFunction: () => Promise<void>;
  FilterClassNotification: () => Promise<void>;

  // staff Notification
  StaffNotificationFunction: () => Promise<void>;
  FilterStaffNotification: () => Promise<void>;

  //school event
  SchoolEventFunction: () => Promise<void>;
  FilterSchoolEvent: () => Promise<void>;

  // Assignment 
  AssignmentFunction: () => Promise<void>;
  FilterAssignment: () => Promise<void>; 

  // Assignment Submission
  AssignmentSubmissionFunction: () => Promise<void>;
  FilterAssignmentSubmission: () => Promise<void>; 

  // Class Timetable
  ClassTimetableFunction: () => Promise<void>;
  FilterClassTimetable: () => Promise<void>; 

  // Payment Method
  PaymentMethodFunction: () => Promise<void>
  FilterPaymentMethod: () => Promise<void>

  // School Fees
  SchoolFeesFunction: () => Promise<void>
  FilterSchoolFees: () => Promise<void>

  //All  School Fees Payment
  AllSchoolFeesPaymentFunction: () => Promise<void>
  FilterAllSchoolFeesPayment: () => Promise<void>

  //pending  School Fees Payment
  PendingSchoolFeesPaymentFunction: () => Promise<void>
  FilterPendingSchoolFeesPayment: () => Promise<void>
  
  // success school Fees payment
  SucessSchoolFeesPaymentFunction: () => Promise<void>
  FilterSucessSchoolFeesPayment: () => Promise<void>

  //declined school fees payment
  DeclinedSchoolFeesPaymentFunction: () => Promise<void>
  FilterDeclinedSchoolFeesPayment: () => Promise<void>

  // bills
  BillsFunction: () => Promise<void>
  FilterBills: () => Promise<void>

  // pending Bills
  PendingBillsFunction: () => Promise<void>
  FilterPendingBills: () => Promise<void>

  // success Bills
  SucessBillsFunction: () => Promise<void>
  FilterSucessBills: () => Promise<void>

  // declined Bills'
  DeclinedBillsFunction: () => Promise<void>
  FilterDeclinedBills: () => Promise<void>

  //product categories
  ProductCatergoriesFunction: () => Promise<void>
  FilterProductCatergories: () => Promise<void>

  // product
  ProductFunction: () => Promise<void>
  FilterProduct: () => Promise<void>

  // favourite product
  FavouriteProductFunction: () => Promise<void>
  FilterFavouriteProduct: () => Promise<void>

  // order product
  OrderProductFunction: () => Promise<void>
  FilterOrderProduct: () => Promise<void>
  


}


const AllDataContext = createContext<AllDataContextTye | undefined>(undefined)
export default AllDataContext

export const AllDataProvider = ({children}: {children:ReactNode}) =>{
  const {authTokens} = useContext(AuthContext)!
  
  const [studentCount, setStudentCount] = useState(0)
  const [recentStudent, setRecentStudent] = useState<any[]>([])
  const [studentData, setStudentData] = useState<any>([])
  const [studentLoader, setStudentLoader] = useState(false)
  const [studentSearch, setStudentSearch] = useState('')

  const [staffCount, setStaffCount] = useState(0)
  const [recentStaff, setRecentStaff] = useState<any>([])
  const [staffData, setStaffData] = useState<any>([])
  const [staffLoader, setStaffLoader] = useState(false)
  const [staffSearch, setStaffSearch] = useState('')
  

  const [hrCount, setHrCount] = useState(0)
  const [hrData, setHrData] = useState<any>([])
  const [hrLoader, setHrLoader] = useState(false)
  const [hrSearch, setHrSearch] = useState('')


  const [bursaryCount, setBursaryCount] = useState(0)
  const [bursaryData, setBursaryData] = useState<any>([])
  const [bursaryLoader, setBursaryLoader] = useState(false)
  const [bursarySearch, setBursarySearch] = useState('')


  const [storeKeeperCount, setStoreKeeperCount] = useState(0)
  const [storeKeeperData, setStoreKeeperData] = useState<any>([])
  const [storeKeeperLoader, setStoreKeeperLoader] = useState(false)
  const [storeKeeperSearch, setStoreKeeperSearch] = useState('')


  const [examOfficerCount, setExamOfficerCount] = useState(0)
  const [examOfficerData, setExamOfficerData] = useState<any>([])
  const [examOfficerLoader, setExamOfficerLoader] = useState(false)
  const [examOfficerSearch, setExamOfficerSearch] = useState('')

  const [academicOfficerCount, setAcademicOfficerCount] = useState(0)
  const [academicOfficerData, setAcademicOfficerData] = useState<any>([])
  const [academicOfficerLoader, setAcademicOfficerLoader] = useState(false)
  const [academicOfficerSearch, setAcademicOfficerSearch] = useState('')


  const [otherStaffCount, setOtherStaffCount] = useState(0)
  const [otherStaffData, setOtherStaffData] = useState<any>([])
  const [otherStaffLoader, setOtherStaffLoader] = useState(false)
  const [otherStaffSearch, setOtherStaffSearch] = useState('')

  const [emailCount, setEmailCount] = useState(0)
  const [emailData, setEmailData] = useState<any>([])
  const [recentEmail, setRecentEmail] = useState<any>([])
  const [emailLoader, setEmailLoader] = useState(false)
  const [emailSearch, setEmailSearch] = useState('')

  const [subjectCount, setSubjectCount] = useState(0)
  const [subjectData, setSubjectData] = useState<any>([])
  const [recentSubject, setRecentSubject] = useState<any>([])
  const [subjectLoader, setSubjectLoader] = useState(false)
  const [subjectSearch, setSubjectSearch] = useState('')

  const [termCount, setTermCount] = useState(0)
  const [termData, setTermData] = useState<any>([])
  const [termLoader, setTermLoader] = useState(false)
  const [termSearch, setTermSearch] = useState('')

  const [sessionCount, setSessionCount] = useState(0)
  const [sessionData, setSessionData] = useState<any>([])
  const [currentsession, setCurentSession] = useState<any>([])
  const [sessionLoader, setSessionLoader] = useState(false)
  const [sessionSearch, setSessionSearch] = useState('')

  const [adminHrNotificationCount, setAdminHrNotificationCount] = useState(0)
  const [adminHrNotificationData, setAdminHrNotificationData] = useState<any>([])
  const [recentAdminHrNotification, setRecentAdminHrNotification] = useState<any>([])
  const [adminHrNotificationLoader, setAdminHrNotificationLoader] = useState(false)
  const [adminHrNotificationSearch, setAdminHrNotificationSearch] = useState('')


  const [schoolNotificationCount, setSchoolNotificationCount] = useState(0)
  const [schoolNotificationData, setSchoolNotificationData] = useState<any>([])
  const [recentSchoolNotification, setRecentSchoolNotification] = useState<any>([])
  const [schoolNotificationLoader, setSchoolNotificationLoader] = useState(false)
  const [schoolNotificationSearch, setSchoolNotificationSearch] =   useState('')

  const [classNotificationCount, setClassNotificationCount] = useState(0)
  const [classNotificationData, setClassNotificationData] = useState<any>([])
  const [recentClassNotification, setRecentClassNotification] = useState<any>([])
  const [classNotificationLoader, setClassNotificationLoader] = useState(false)
  const [classNotificationSearch, setClassNotificationSearch] = useState('')

  const [staffNotificationCount, setStaffNotificationCount] = useState(0)
  const [staffNotificationData, setStaffNotificationData] = useState<any>([])
  const [recentStaffNotification, setRecentStaffNotification] = useState<any>([])
  const [staffNotificationLoader, setStaffNotificationLoader] = useState(false)
  const [staffNotificationSearch, setStaffNotificationSearch] = useState('')

  const [schoolEventCount, setSchoolEventCount] = useState(0)
  const [schoolEventData, setSchoolEventData] = useState<any>([])
  const [recentSchoolEvent, setRecentSchoolEvent] = useState<any>([])
  const [schoolEventLoader, setSchoolEventLoader] = useState(false)
  const [schoolEventSearch, setSchoolEventSearch] = useState('')

  const [assignmentCount, setAssignmentCount] = useState(0)
  const [assignmentData, setAssignmentData] = useState<any>([])
  const [recentAssignment, setRecentAssignment] = useState<any>([])
  const [assignmentLoader, setAssignmentLoader] = useState(false)
  const [assignmentSearch, setAssignmentSearch] = useState('')


  const [assignmentSubmissionCount, setAssignmentSubmissionCount] = useState(0)
  const [assignmentSubmissionData, setAssignmentSubmissionData] = useState<any>([])
  const [recentAssignmentSubmission, setRecentAssignmentSubmission] = useState<any>([])
  const [assignmentSubmissionLoader, setAssignmentSubmissionLoader] = useState(false)
  const [assignmentSubmissionSearch, setAssignmentSubmissionSearch] = useState('')

  const [classTimetableCount, setClassTimetableCount] = useState(0)
  const [classTimetableData, setClassTimetableData] = useState<any>([])
  const [recentClassTimetable, setRecentClassTimetable] = useState<any>([])
  const [classTimetableLoader, setClassTimetableLoader] = useState(false)
  const [classTimetableSearch, setClassTimetableSearch] = useState('')


  const [paymentMethodCount, setPaymentMethodCount] = useState(0)
  const [paymentMethodData, setPaymentMethodData] = useState<any>([])
  const [recentPaymentMethod, setRecentPaymentMethod] = useState<any>([])
  const [paymentMethodLoader, setPaymentMethodLoader] = useState(false)
  const [paymentMethodSearch, setPaymentMethodSearch] = useState('')


  const [schoolFeesCount, setSchoolFeesCount] = useState(0)
  const [schoolFeesData, setSchoolFeesData] = useState<any>([])
  const [schoolFeesLoader, setSchoolFeesLoader] = useState(false)
  const [schoolFeesSearch, setSchoolFeesSearch] = useState('')

  const [allSchoolFeesPaymentCount, setAllSchoolFeesPaymentCount] = useState(0)
  const [recentAllSchoolFeesPayment, setRecentAllSchoolFeesPayment] = useState<any>([])
  const [allSchoolFeesPaymentData, setAllSchoolFeesPaymentData] = useState<any>([])
  const [allSchoolFeesPaymentLoader, setAllSchoolFeesPaymentLoader] = useState(false)
  const [allSchoolFeesPaymentSearch, setAllSchoolFeesPaymentSearch] = useState('')

  const [pendingSchoolFeesPaymentCount, setPendingSchoolFeesPaymentCount] = useState(0)
  const [recentPendingSchoolFeesPayment, setRecentPendingSchoolFeesPayment] = useState<any>([])
  const [pendingSchoolFeesPaymentData, setPendingSchoolFeesPaymentData] = useState<any>([])
  const [pendingSchoolFeesPaymentLoader, setPendingSchoolFeesPaymentLoader] = useState(false)
  const [pendingSchoolFeesPaymentSearch, setPendingSchoolFeesPaymentSearch] = useState('')
  

  const [sucessSchoolFeesPaymentCount, setSucessSchoolFeesPaymentCount] = useState(0)
  const [recentSucessSchoolFeesPayment, setRecentSucessSchoolFeesPayment] = useState<any>([])
  const [sucessSchoolFeesPaymentData, setSucessSchoolFeesPaymentData] = useState<any>([])
  const [sucessSchoolFeesPaymentLoader, setSucessSchoolFeesPaymentLoader] = useState(false)
  const [sucessSchoolFeesPaymentSearch, setSucessSchoolFeesPaymentSearch] = useState('')
  
  const [declinedSchoolFeesPaymentCount, setDeclinedSchoolFeesPaymentCount] = useState(0)
  const [recentDeclinedSchoolFeesPayment, setRecentDeclinedSchoolFeesPayment] = useState<any>([])
  const [declinedSchoolFeesPaymentData, setDeclinedSchoolFeesPaymentData] = useState<any>([])
  const [declinedSchoolFeesPaymentLoader, setDeclinedSchoolFeesPaymentLoader] = useState(false)
  const [declinedSchoolFeesPaymentSearch, setDeclinedSchoolFeesPaymentSearch] = useState('')

  const [billsCount, setBillsCount] = useState(0)
  const [billsData, setBillsData] = useState<any>([])
  const [recentBills, setRecentBills] = useState<any[]>([])
  const [billsLoader, setBillsLoader] = useState(false)
  const [billsSearch, setBillsSearch] = useState('')


  const [pendingBillsCount, setPendingBillsCount] = useState(0)
  const [recentPendingBills, setRecentPendingBills] = useState<any>([])
  const [pendingBillsData, setPendingBillsData] = useState<any>([])
  const [pendingBillsLoader, setPendingBillsLoader] = useState(false)
  const [pendingBillsSearch, setPendingBillsSearch] = useState('')
  

  const [sucessBillsCount, setSucessBillsCount] = useState(0)
  const [recentSucessBills, setRecentSucessBills] = useState<any>([])
  const [sucessBillsData, setSucessBillsData] = useState<any>([])
  const [sucessBillsLoader, setSucessBillsLoader] = useState(false)
  const [sucessBillsSearch, setSucessBillsSearch] = useState('')
  
  const [declinedBillsCount, setDeclinedBillsCount] = useState(0)
  const [recentDeclinedBills, setRecentDeclinedBills] = useState<any>([])
  const [declinedBillsData, setDeclinedBillsData] = useState<any>([])
  const [declinedBillsLoader, setDeclinedBillsLoader] = useState(false)
  const [declinedBillsSearch, setDeclinedBillsSearch] = useState('')

  const [productCatergoriesCount, setProductCatergoriesCount] = useState(0)
  const [productCatergoriesData, setProductCatergoriesData] = useState<any>([])
  const [productCatergoriesLoader, setProductCatergoriesLoader] = useState(false)
  const [productCatergoriesSearch, setProductCatergoriesSearch] = useState('')


  const [productCount, setProductCount] = useState(0)
  const [productData, setProductData] = useState<any>([])
  const [recentProduct, setRecentProduct] = useState<any>([])
  const [productLoader, setProductLoader] = useState(false)
  const [productSearch, setProductSearch] = useState('')

  const [favouriteProductCount, setFavouriteProductCount] = useState(0)
  const [favouriteProductData, setFavouriteProductData] = useState<any>([])
  const [recentFavouriteProduct, setRecentFavouriteProduct] = useState<any>([])
  const [favouriteProductLoader, setFavouriteProductLoader] = useState(false)
  const [favouriteProductSearch, setFavouriteProductSearch] = useState("")

  const [orderProductCount, setOrderProductCount] = useState(0)
  const [orderProductData, setOrderProductData] = useState<any>([])
  const [recentOrderProduct, setRecentOrderProduct] = useState<any>([])
  const [orderProductLoader, setOrderProductLoader] = useState(false)
  const [orderProductSearch, setOrderProductSearch] =  useState('')



  const StudentFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/students/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setStudentCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      
      // sort by latest 5
      const RecentsortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = RecentsortedData.slice(0, 4);
      setRecentStudent(recentData)
      setStudentData(sortedData)
      setStudentLoader(false)


    }else{
      setStudentLoader(false)
    }



  }


  const FilterStudent = async() =>{
    let url;

    if(studentSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/students/?search=${studentSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      setStudentData(sortedData)
    }
  }

  // Staff
  const StaffFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/staff/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setStaffCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));

      // sort by latest 5
      const RecentsortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = RecentsortedData.slice(0, 4);
      setRecentStaff(recentData)
      setStaffData(sortedData)
      setStaffLoader(false)


    }else{
      setStaffLoader(false)
    }



  }


  const FilterStaff = async() =>{
    let url;

    if(staffSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/staff/?search=${staffSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
       setStaffData(sortedData)
    }
  }


  // HR
  const HrFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/hr/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setHrCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));

      // sort by latest 5
      const RecentsortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
           
      const recentData = RecentsortedData.slice(0, 4);
      setHrData(sortedData)
      setHrLoader(false)


    }else{
      setHrLoader(false)
    }



  }


  const FilterHr = async() =>{
    let url;

    if(hrSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/hr/?search=${hrSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
       setHrData(sortedData)
    }
  }


  // Bursary
  const BursaryFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/bursary/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setBursaryCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      setBursaryData(sortedData)
      setBursaryLoader(false)


    }else{
      setBursaryLoader(false)
    }



  }


  const FilterBursary = async() =>{
    let url;

    if(bursarySearch.length !== 0){
      url = `http://127.0.0.1:8000/api/bursary/?search=${bursarySearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
        // sorting from A to Z
        const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
        setBursaryData(sortedData)
    }
  }

  // Store Keeper
  const StoreKeeperFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/store_keeper/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setStoreKeeperCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      setStoreKeeperData(sortedData)
      setStoreKeeperLoader(false)


    }else{
      setStoreKeeperLoader(false)
    }



  }


  const FilterStoreKeeper = async() =>{
    let url;

    if(storeKeeperSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/store_keeper/?search=${storeKeeperSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
        // sorting from A to Z
        const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
        setStoreKeeperData(sortedData)
    }
  }

  // Exam Officer
  const ExamOfficerFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/exam-officer/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setExamOfficerCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      setExamOfficerData(sortedData)
      setExamOfficerLoader(false)


    }else{
      setExamOfficerLoader(false)
    }



  }


  const FilterExamOfficer = async() =>{
    let url;

    if(examOfficerSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/exam-officer/?search=${examOfficerSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
        // sorting from A to Z
        const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
        setExamOfficerData(sortedData)
    }
  }

  // Academic Officer
  const AcademicOfficerFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/academic-officer/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setAcademicOfficerCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      setAcademicOfficerData(sortedData)
      setAcademicOfficerLoader(false)


    }else{
      setAcademicOfficerLoader(false)
    }



  }


  const FilterAcademicOfficer = async() =>{
    let url;

    if(academicOfficerSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/academic-officer/?search=${academicOfficerSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
        // sorting from A to Z
        const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
        setAcademicOfficerData(sortedData)
    }
  }

  //  other Staff
  const OtherStaffFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/other-staff/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setOtherStaffCount(data.length)
      }
      // sorting from A to Z
      const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
      setOtherStaffData(sortedData)
      setOtherStaffLoader(false)


    }else{
      setOtherStaffLoader(false)
    }



  }


  const FilterOtherStaff = async() =>{
    let url;

    if(otherStaffSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/other-staff/?search=${otherStaffSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
        // sorting from A to Z
        const sortedData = data.sort((a: {first_name: string}, b: {first_name:string}) => a.first_name.localeCompare(b.first_name));
        setOtherStaffData(sortedData)
    }
  }

  // email
  const EmailFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/email/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setEmailCount(data.length)
      }
      
      
      // sort by latest 
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentEmail(recentData)
      setEmailData(sortedData)
      setEmailLoader(false)


    }else{
      setEmailLoader(false)
    }



  }


  const FilterEmail = async() =>{
    let url;

    if(emailSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/email/?search=${emailSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setEmailData(sortedData)
    }
  }


  //subject
  const SubjectFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/subjects/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSubjectCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: {name: string}, b: {name:string}) => a.name.localeCompare(b.name));

      // sort by latest 5
      const RecentsortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);

      const recentData = RecentsortedData.slice(0, 4);
      setRecentSubject(recentData)
      setSubjectData(sortedData)
      setSubjectLoader(false)


    }else{
      setSubjectLoader(false)
    }



  }


  const FilterSubject = async() =>{
    let url;

    if(subjectSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/subjects/?search=${subjectSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: {name: string}, b: {name:string}) => a.name.localeCompare(b.name));
       setSubjectData(sortedData)
    }
  }

  // Term
  const TermFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/term/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setTermCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: {name: string}, b: {name:string}) => a.name.localeCompare(b.name));
      setTermData(sortedData)
      setTermLoader(false)


    }else{
      setTermLoader(false)
    }



  }


  const FilterTerm = async() =>{
    let url;

    if(termSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/term/?search=${termSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setTermSearch(sortedData)
    }
  }

 // session
  const SessionFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/session/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSessionCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData[-1];
      setCurentSession(recentData)
      setSessionData(sortedData)
      setSessionLoader(false)


    }else{
      setSessionLoader(false)
    }



  }


  const FilterSession = async() =>{
    let url;

    if(sessionSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/session/?search=${sessionSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setSessionData(sortedData)
    }
  }


  // Admin or hr Notification
  const AdminHrNotificationFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/admin-or-hr-notification/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setAdminHrNotificationCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentAdminHrNotification(recentData)
      setAdminHrNotificationData(sortedData)
      setAdminHrNotificationLoader(false)


    }else{
      setAdminHrNotificationLoader(false)
    }



  }


  const FilteradminHrNotification = async() =>{
    let url;

    if(adminHrNotificationSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/admin-or-hr-notification/?search=${adminHrNotificationSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setAdminHrNotificationData(sortedData)
    }
  }

  //School Notification
  const SchoolNotificationFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/school-notification/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSchoolNotificationCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentSchoolNotification(recentData)
      setSchoolNotificationData(sortedData)
      setSchoolNotificationLoader(false)


    }else{
      setSchoolNotificationLoader(false)
    }



  }


  const FilterSchoolNotification = async() =>{
    let url;

    if(schoolNotificationSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/school-notification/?search=${schoolNotificationSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setAdminHrNotificationData(sortedData)
    }
  }

 // class Notififcatiion
  const ClassNotificationFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/class-notification/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setClassNotificationCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentClassNotification(recentData)
      setClassNotificationData(sortedData)
      setClassNotificationLoader(false)


    }else{
      setClassNotificationLoader(false)
    }



  }


  const FilterClassNotification = async() =>{
    let url;

    if(classNotificationSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/class-notification/?search=${classNotificationSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setClassNotificationData(sortedData)
    }
  }


  // staff Notification
  const StaffNotificationFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/staff-notification/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setStaffNotificationCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentStaffNotification(recentData)
      setStaffNotificationData(sortedData)
      setStaffNotificationLoader(false)


    }else{
      setStaffNotificationLoader(false)
    }



  }


  const FilterStaffNotification = async() =>{
    let url;

    if(staffNotificationSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/staff-notification/?search=${staffNotificationSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setStaffNotificationData(sortedData)
    }
  }


  // School Event
  const SchoolEventFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/school-event/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSchoolEventCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentSchoolEvent(recentData)
      setSchoolEventData(sortedData)
      setSchoolEventLoader(false)


    }else{
      setSchoolEventLoader(false)
    }



  }


  const FilterSchoolEvent = async() =>{
    let url;

    if(schoolEventSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/school-event/?search=${schoolEventSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setSchoolEventData(sortedData)
    }
  }


  // Assignment
  const AssignmentFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/assignment/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setAssignmentCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentAssignment(recentData)
      setAssignmentData(sortedData)
      setAssignmentLoader(false)


    }else{
      setAssignmentLoader(false)
    }



  }


  const FilterAssignment = async() =>{
    let url;

    if(assignmentSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/assignment/?search=${assignmentSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setAssignmentData(sortedData)
    }
  }


  // Asignment Submission
  const AssignmentSubmissionFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/assignment-submission/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setAssignmentSubmissionCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentAssignmentSubmission(recentData)
      setAssignmentSubmissionData(sortedData)
      setAssignmentSubmissionLoader(false)


    }else{
      setAssignmentSubmissionLoader(false)
    }



  }


  const FilterAssignmentSubmission = async() =>{
    let url;

    if(assignmentSubmissionSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/assignment-submission/?search=${assignmentSubmissionSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setAssignmentSubmissionData(sortedData)
    }
  }


  // Class Timetable
  const ClassTimetableFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/class-timetable/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setClassTimetableCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { student_class_name: { name: string } }, b: { student_class_name: { name: string } }) => a.student_class_name.name.localeCompare(b.student_class_name.name));
      const recentData = sortedData.slice(0, 4);
      setRecentClassTimetable(recentData)
      setClassTimetableData(sortedData)
      setClassTimetableLoader(false)


    }else{
      setClassTimetableLoader(false)
    }



  }


  const FilterClassTimetable = async() =>{
    let url;

    if(classTimetableSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/class-timetable/?search=${classTimetableSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { student_class_name: { name: string } }, b: { student_class_name: { name: string } }) => a.student_class_name.name.localeCompare(b.student_class_name.name));
       setClassTimetableData(sortedData)
    }
  }

  // Payment Mehthod
  const PaymentMethodFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/payment-method/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setPaymentMethodCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentPaymentMethod(recentData)
      setPaymentMethodData(sortedData)
      setPaymentMethodLoader(false)


    }else{
      setPaymentMethodLoader(false)
    }



  }


  const FilterPaymentMethod = async() =>{
    let url;

    if(paymentMethodSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/payment-method/?search=${paymentMethodSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setPaymentMethodData(sortedData)
    }
  }


  // school fees
  const SchoolFeesFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/school-fees/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSchoolFeesCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { student_class_name: { name: string } }, b: { student_class_name: { name: string } }) => a.student_class_name.name.localeCompare(b.student_class_name.name));
      setSchoolFeesData(sortedData)
      setSchoolFeesLoader(false)


    }else{
      setSchoolFeesLoader(false)
    }



  }


  const FilterSchoolFees = async() =>{
    let url;

    if(schoolFeesSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/school-fees/?search=${schoolFeesSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { student_class_name: { name: string } }, b: { student_class_name: { name: string } }) => a.student_class_name.name.localeCompare(b.student_class_name.name));
       setSchoolFeesData(sortedData)
    }
  }


    //All  School Fees Payment
  const AllSchoolFeesPaymentFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/payment-school-fees/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setAllSchoolFeesPaymentCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentAllSchoolFeesPayment(recentData)
      setAllSchoolFeesPaymentData(sortedData)
      setAllSchoolFeesPaymentLoader(false)


    }else{
      setAllSchoolFeesPaymentLoader(false)
    }



  }


  const FilterAllSchoolFeesPayment = async() =>{
    let url;

    if(allSchoolFeesPaymentSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/payment-school-fees/?search=${allSchoolFeesPaymentSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setAllSchoolFeesPaymentData(sortedData)
    }
  }

  //pending  School Fees Payment
  const PendingSchoolFeesPaymentFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/payment-school-fees/pending/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setPendingSchoolFeesPaymentCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentPendingSchoolFeesPayment(recentData)
      setPendingSchoolFeesPaymentData(sortedData)
      setPendingSchoolFeesPaymentLoader(false)


    }else{
      setPendingSchoolFeesPaymentLoader(false)
    }



  }


  const FilterPendingSchoolFeesPayment = async() =>{
    let url;

    if(pendingSchoolFeesPaymentSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/payment-school-fees/pending/?search=${pendingSchoolFeesPaymentSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setPendingSchoolFeesPaymentData(sortedData)
    }
  }

  // success school Fees payment
  const SucessSchoolFeesPaymentFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/payment-school-fees/successful/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSucessSchoolFeesPaymentCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentSucessSchoolFeesPayment(recentData)
      setSucessSchoolFeesPaymentData(sortedData)
      setSucessSchoolFeesPaymentLoader(false)


    }else{
      setSucessSchoolFeesPaymentLoader(false)
    }



  }


  const FilterSucessSchoolFeesPayment = async() =>{
    let url;

    if(sucessSchoolFeesPaymentSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/payment-school-fees/successful/?search=${sucessSchoolFeesPaymentSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setSucessSchoolFeesPaymentData(sortedData)
    }
  }

  // declined school Fees payment
  const DeclinedSchoolFeesPaymentFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/payment-school-fees/declined/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setDeclinedSchoolFeesPaymentCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentDeclinedSchoolFeesPayment(recentData)
      setDeclinedSchoolFeesPaymentData(sortedData)
      setDeclinedSchoolFeesPaymentLoader(false)


    }else{
      setDeclinedSchoolFeesPaymentLoader(false)
    }



  }


  const FilterDeclinedSchoolFeesPayment = async() =>{
    let url;

    if(declinedSchoolFeesPaymentSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/payment-school-fees/declined/?search=${declinedSchoolFeesPaymentSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setDeclinedSchoolFeesPaymentData(sortedData)
    }
  }


  // bills
  const BillsFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/bills/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setBillsCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentBills(recentData)
      setBillsData(sortedData)
      setBillsLoader(false)


    }else{
      setBillsLoader(false)
    }



  }


  const FilterBills = async() =>{
    let url;

    if(billsSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/bills/?search=${billsSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setBillsData(sortedData)
    }
  }


  // pending Bills
  const PendingBillsFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/bills/pending/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setPendingBillsCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentPendingBills(recentData)
      setPendingBillsData(sortedData)
      setPendingBillsLoader(false)


    }else{
      setPendingBillsLoader(false)
    }



  }


  const FilterPendingBills = async() =>{
    let url;

    if(pendingBillsSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/bills/pending/?search=${pendingBillsSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setPendingBillsData(sortedData)
    }
  }


  // success Bills
  const SucessBillsFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/bills/successful/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSucessBillsCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentSucessBills(recentData)
      setSucessBillsData(sortedData)
      setSucessBillsLoader(false)


    }else{
      setSucessBillsLoader(false)
    }



  }


  const FilterSucessBills = async() =>{
    let url;

    if(sucessBillsSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/bills/successful/?search=${sucessBillsSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setSucessBillsData(sortedData)
    }
  }

// declined Bills'
  const DeclinedBillsFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/bills/declined/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setDeclinedBillsCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentDeclinedBills(recentData)
      setDeclinedBillsData(sortedData)
      setDeclinedBillsLoader(false)


    }else{
      setDeclinedBillsLoader(false)
    }



  }


  const FilterDeclinedBills = async() =>{
    let url;

    if(declinedBillsSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/bills/declined/?search=${declinedBillsSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setDeclinedBillsData(sortedData)
    }
  }


  //product categories
  const ProductCatergoriesFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/product-categories/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setProductCatergoriesCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      setProductCatergoriesData(sortedData)
      setProductCatergoriesLoader(false)


    }else{
      setProductCatergoriesLoader(false)
    }



  }


  const FilterProductCatergories = async() =>{
    let url;

    if(productCatergoriesSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/product-categories/?search=${productCatergoriesSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setProductCatergoriesData(sortedData)
    }
  }


  // product
  const ProductFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/product/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setProductCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentProduct(recentData)
      setProductData(sortedData)
      setProductLoader(false)


    }else{
      setProductLoader(false)
    }



  }


  const FilterProduct = async() =>{
    let url;

    if(productSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/product/?search=${productSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setProductData(sortedData)
    }
  }

    // favourite product
  const FavouriteProductFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/favorite-products/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setFavouriteProductCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentFavouriteProduct(recentData)
      setFavouriteProductData(sortedData)
      setFavouriteProductLoader(false)


    }else{
      setFavouriteProductLoader(false)
    }



  }


  const FilterFavouriteProduct = async() =>{
    let url;

    if(favouriteProductSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/favorite-products/?search=${favouriteProductSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setFavouriteProductData(sortedData)
    }
  }

  // order product
  const OrderProductFunction = async() =>{
    let response = await fetch('http://127.0.0.1:8000/api/order-products/', {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setOrderProductCount(data.length)
      }
      
      

      // sorting from A to Z
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      const recentData = sortedData.slice(0, 4);
      setRecentOrderProduct(recentData)
      setOrderProductData(sortedData)
      setOrderProductLoader(false)


    }else{
      setOrderProductLoader(false)
    }



  }


  const FilterOrderProduct = async() =>{
    let url;

    if(orderProductSearch.length !== 0){
      url = `http://127.0.0.1:8000/api/order-products/?search=${orderProductSearch}`
    }


    if (!url) {
      console.error("URL is undefined");
      return;
    }

    let response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type":"application/json",
        Authorization: `Bearer ${authTokens?.access}`
      }
    });

    const data = await response.json()

    if(response.ok){
       // sorting from A to Z
       const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
       setOrderProductData(sortedData)
    }
  }













  const contextData ={
    studentCount, setStudentCount,
    recentStudent, setRecentStudent,
    studentData, setStudentData,
    studentLoader, setStudentLoader,
    studentSearch, setStudentSearch,

    staffCount, setStaffCount,
    recentStaff, setRecentStaff,
    staffData, setStaffData,
    staffLoader,setStaffLoader,
    staffSearch, setStaffSearch,

    hrCount, setHrCount,
    hrData,setHrData,
    hrLoader, setHrLoader,
    hrSearch, setHrSearch,

    bursaryCount, setBursaryCount,
    bursaryData, setBursaryData,
    bursaryLoader, setBursaryLoader,
    bursarySearch, setBursarySearch,

    storeKeeperCount,setStoreKeeperCount,
    storeKeeperData, setStoreKeeperData,
    storeKeeperLoader, setStoreKeeperLoader,
    storeKeeperSearch, setStoreKeeperSearch,


    examOfficerCount, setExamOfficerCount,
    examOfficerData, setExamOfficerData,
    examOfficerLoader,setExamOfficerLoader,
    examOfficerSearch, setExamOfficerSearch,


    academicOfficerCount, setAcademicOfficerCount,
    academicOfficerData, setAcademicOfficerData,
    academicOfficerLoader, setAcademicOfficerLoader,
    academicOfficerSearch, setAcademicOfficerSearch,

    otherStaffCount, setOtherStaffCount,
    otherStaffData, setOtherStaffData,
    otherStaffLoader,setOtherStaffLoader,
    otherStaffSearch, setOtherStaffSearch,

    emailCount, setEmailCount,
    emailData, setEmailData,
    recentEmail, setRecentEmail,
    emailLoader, setEmailLoader,
    emailSearch, setEmailSearch,


    subjectCount, setSubjectCount,
    subjectData, setSubjectData,
    recentSubject, setRecentSubject,
    subjectLoader, setSubjectLoader,
    subjectSearch, setSubjectSearch,

    termCount, setTermCount,
    termData, setTermData,
    termLoader, setTermLoader,
    termSearch, setTermSearch,

    sessionCount, setSessionCount,
    sessionData, setSessionData,
    currentsession, setCurentSession,
    sessionLoader, setSessionLoader,
    sessionSearch, setSessionSearch,


    adminHrNotificationCount, setAdminHrNotificationCount,
    adminHrNotificationData,  setAdminHrNotificationData,
    recentAdminHrNotification, setRecentAdminHrNotification,
    adminHrNotificationLoader, setAdminHrNotificationLoader,
    adminHrNotificationSearch, setAdminHrNotificationSearch,

    schoolNotificationCount, setSchoolNotificationCount,
    schoolNotificationData, setSchoolNotificationData,
    recentSchoolNotification, setRecentSchoolNotification,
    schoolNotificationLoader, setSchoolNotificationLoader,
    schoolNotificationSearch, setSchoolNotificationSearch,


    classNotificationCount, setClassNotificationCount,
    classNotificationData, setClassNotificationData,
    recentClassNotification, setRecentClassNotification,
    classNotificationLoader, setClassNotificationLoader,
    classNotificationSearch, setClassNotificationSearch,


    staffNotificationCount, setStaffNotificationCount,
    staffNotificationData, setStaffNotificationData,
    recentStaffNotification, setRecentStaffNotification,
    staffNotificationLoader, setStaffNotificationLoader,
    staffNotificationSearch, setStaffNotificationSearch,

    schoolEventCount, setSchoolEventCount,
    schoolEventData, setSchoolEventData,
    recentSchoolEvent, setRecentSchoolEvent,
    schoolEventLoader, setSchoolEventLoader,
    schoolEventSearch, setSchoolEventSearch,


    assignmentCount, setAssignmentCount,
    assignmentData, setAssignmentData,
    recentAssignment, setRecentAssignment,
    assignmentLoader, setAssignmentLoader,
    assignmentSearch, setAssignmentSearch,

    assignmentSubmissionCount, setAssignmentSubmissionCount,
    assignmentSubmissionData, setAssignmentSubmissionData,
    recentAssignmentSubmission, setRecentAssignmentSubmission,
    assignmentSubmissionLoader, setAssignmentSubmissionLoader,
    assignmentSubmissionSearch, setAssignmentSubmissionSearch,

    classTimetableCount, setClassTimetableCount,
    classTimetableData, setClassTimetableData,
    recentClassTimetable, setRecentClassTimetable,
    classTimetableLoader, setClassTimetableLoader,
    classTimetableSearch, setClassTimetableSearch,

    paymentMethodCount, setPaymentMethodCount,
    paymentMethodData, setPaymentMethodData,
    recentPaymentMethod, setRecentPaymentMethod,
    paymentMethodLoader, setPaymentMethodLoader,
    paymentMethodSearch, setPaymentMethodSearch,


    schoolFeesCount, setSchoolFeesCount,
    schoolFeesData, setSchoolFeesData,
    schoolFeesLoader, setSchoolFeesLoader,
    schoolFeesSearch, setSchoolFeesSearch,

    allSchoolFeesPaymentCount, setAllSchoolFeesPaymentCount,
    recentAllSchoolFeesPayment, setRecentAllSchoolFeesPayment,
    allSchoolFeesPaymentData, setAllSchoolFeesPaymentData,
    allSchoolFeesPaymentLoader, setAllSchoolFeesPaymentLoader,
    allSchoolFeesPaymentSearch, setAllSchoolFeesPaymentSearch,

    pendingSchoolFeesPaymentCount, setPendingSchoolFeesPaymentCount,
    recentPendingSchoolFeesPayment, setRecentPendingSchoolFeesPayment,
    pendingSchoolFeesPaymentData, setPendingSchoolFeesPaymentData,
    pendingSchoolFeesPaymentLoader, setPendingSchoolFeesPaymentLoader,
    pendingSchoolFeesPaymentSearch, setPendingSchoolFeesPaymentSearch,


    sucessSchoolFeesPaymentCount, setSucessSchoolFeesPaymentCount,
    recentSucessSchoolFeesPayment, setRecentSucessSchoolFeesPayment,
    sucessSchoolFeesPaymentData, setSucessSchoolFeesPaymentData,
    sucessSchoolFeesPaymentLoader, setSucessSchoolFeesPaymentLoader,
    sucessSchoolFeesPaymentSearch, setSucessSchoolFeesPaymentSearch,

    declinedSchoolFeesPaymentCount, setDeclinedSchoolFeesPaymentCount,
    recentDeclinedSchoolFeesPayment, setRecentDeclinedSchoolFeesPayment,
    declinedSchoolFeesPaymentData, setDeclinedSchoolFeesPaymentData,
    declinedSchoolFeesPaymentLoader, setDeclinedSchoolFeesPaymentLoader,
    declinedSchoolFeesPaymentSearch, setDeclinedSchoolFeesPaymentSearch,



    billsCount, setBillsCount,
    recentBills, setRecentBills,
    billsData, setBillsData,
    billsLoader, setBillsLoader,
    billsSearch, setBillsSearch,

    pendingBillsCount, setPendingBillsCount,
    recentPendingBills, setRecentPendingBills,
    pendingBillsData, setPendingBillsData,
    pendingBillsLoader, setPendingBillsLoader,
    pendingBillsSearch, setPendingBillsSearch,


    sucessBillsCount, setSucessBillsCount,
    recentSucessBills, setRecentSucessBills,
    sucessBillsData, setSucessBillsData,
    sucessBillsLoader, setSucessBillsLoader,
    sucessBillsSearch, setSucessBillsSearch,

    declinedBillsCount, setDeclinedBillsCount,
    recentDeclinedBills, setRecentDeclinedBills,
    declinedBillsData, setDeclinedBillsData,
    declinedBillsLoader, setDeclinedBillsLoader,
    declinedBillsSearch, setDeclinedBillsSearch,

    productCatergoriesCount, setProductCatergoriesCount,
    productCatergoriesData, setProductCatergoriesData,
    productCatergoriesLoader, setProductCatergoriesLoader,
    productCatergoriesSearch, setProductCatergoriesSearch,

    productCount, setProductCount,
    productData, setProductData,
    recentProduct, setRecentProduct,
    productLoader, setProductLoader,
    productSearch, setProductSearch,

    favouriteProductCount, setFavouriteProductCount,
    favouriteProductData, setFavouriteProductData,
    recentFavouriteProduct, setRecentFavouriteProduct,
    favouriteProductLoader, setFavouriteProductLoader,
    favouriteProductSearch, setFavouriteProductSearch,

    orderProductCount, setOrderProductCount,
    orderProductData, setOrderProductData,
    recentOrderProduct, setRecentOrderProduct,
    orderProductLoader, setOrderProductLoader,
    orderProductSearch, setOrderProductSearch,



    //  ----------------------------------------------- Function -----------------------------------------------//
    StudentFunction, FilterStudent,
    StaffFunction,  FilterStaff,
    HrFunction, FilterHr,
    BursaryFunction, FilterBursary,
    StoreKeeperFunction, FilterStoreKeeper,
    ExamOfficerFunction,  FilterExamOfficer,
    AcademicOfficerFunction, FilterAcademicOfficer,
    OtherStaffFunction , FilterOtherStaff,
    EmailFunction,  FilterEmail,
    SubjectFunction, FilterSubject,
    TermFunction,  FilterTerm,
    SessionFunction, FilterSession,
    AdminHrNotificationFunction, FilteradminHrNotification,
    SchoolNotificationFunction, FilterSchoolNotification,
    ClassNotificationFunction,  FilterClassNotification,
    StaffNotificationFunction, FilterStaffNotification,
    SchoolEventFunction, FilterSchoolEvent,
    AssignmentFunction, FilterAssignment,
    AssignmentSubmissionFunction, FilterAssignmentSubmission,
    ClassTimetableFunction, FilterClassTimetable,
    PaymentMethodFunction, FilterPaymentMethod,
    SchoolFeesFunction, FilterSchoolFees,

    AllSchoolFeesPaymentFunction, FilterAllSchoolFeesPayment,
    PendingSchoolFeesPaymentFunction, FilterPendingSchoolFeesPayment,
    SucessSchoolFeesPaymentFunction, FilterSucessSchoolFeesPayment,
    DeclinedSchoolFeesPaymentFunction, FilterDeclinedSchoolFeesPayment,

    BillsFunction, FilterBills,
    PendingBillsFunction, FilterPendingBills,
    SucessBillsFunction, FilterSucessBills,
    DeclinedBillsFunction, FilterDeclinedBills,

    ProductCatergoriesFunction, FilterProductCatergories,
    ProductFunction, FilterProduct,
    FavouriteProductFunction, FilterFavouriteProduct,
    OrderProductFunction, FilterOrderProduct,
    





    

  }

  return(
    <AllDataContext.Provider value={contextData}>
      {children}
    </AllDataContext.Provider>
  )

}
