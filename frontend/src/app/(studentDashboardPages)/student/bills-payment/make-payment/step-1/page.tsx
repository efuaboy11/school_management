"use client"
import AllDataContext from '@/context/AllData'
import AuthContext from '@/context/AuthContext'
import ThemeContext from '@/context/ThemeContext'
import { useRouter } from 'next/navigation'
import React, { useContext, useEffect, useState } from 'react'
import { useForm } from 'react-hook-form'
import Select from 'react-select';
import { useDropzone } from 'react-dropzone';
import Link from 'next/link'

const PayBills = () => {
  const [bills, setBills] = useState('')
  const [paymentMethod, setPaymentMethod] = useState('')

  const router = useRouter();
  const [isClient, setIsClient] = useState(false);
  const { theme, toggleTheme } = useContext(ThemeContext)!;
  useEffect(() => {
    setIsClient(true);
  }, []);
  

  

  const { 
    authTokens,
  
    loader,
    setLoader,
    disableButton,
    setDisableButton,
    formatName,
    formatCurrency,
  
    setMessage,
    showAlert,
    setIsSuccess,
  
  } = useContext(AuthContext)!


  const {
    PaymentMethodFunction,
    paymentMethodData,

    billsData,
    BillsFunction,



  } = useContext(AllDataContext)!;

  


  const {
    register,
    handleSubmit,
    formState: {errors, isValid},
  } = useForm<any>();







  const customStyles = {
    control: (provided: any, state: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#0d0d0d' : '#fff',
      borderColor: state.isFocused ? '#783ebc' : theme === 'light' ? '#ccc' : '#333',
      boxShadow: state.isFocused ? '0 0 0 4px rgba(120, 62, 188, 0.2)' : 'none',
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    menu: (provided: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#0d0d0d' : '#fff',
      border: '1px solid #ccc',
      zIndex: 999,
    }),
  
    option: (provided: any, state: any) => {
      const isDark = theme === 'dark';
  
      const backgroundColor = state.isSelected
        ? '#783ebc'
        : state.isFocused
        ? isDark
          ? '#1a1a1a' // hover in dark
          : '#f0f0f0' // hover in light
        : isDark
        ? '#0d0d0d'
        : '#fff';
  
      const color = state.isSelected
        ? '#fff'
        : state.isFocused
        ? isDark
          ? '#fff'
          : '#000'
        : isDark
        ? '#fff'
        : '#000';
  
      return {
        ...provided,
        backgroundColor,
        color,
        cursor: 'pointer',
      };
    },
  
    singleValue: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    placeholder: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#aaa' : '#666',
    }),
  
    input: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    dropdownIndicator: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    indicatorSeparator: (provided: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#444' : '#ccc',
    }),
  };


  const onSubmit = (data: FormData, e:any) => {
    setLoader(true)
    router.push(`/student/bills-payment/make-payment/step-2/${bills}/${paymentMethod}`)
  }


  
  useEffect(() => {
    PaymentMethodFunction()
    BillsFunction()
    setLoader(false)
  }, [])





  return (
    <div>

      <div className="container-lg  pt-5 mb-5 pb-4">
        <div className='row justify-content-center'>
          <div className="col-sm-6">
            <div className="site-boxes border-radius-10px">
              <div className="border-bottom1 p-3">
                <p className='text-center'>Bills Payment</p>
              </div>

              <div className='mt- p-3'>
                  <form onSubmit={handleSubmit(onSubmit)}>
                    <div className="row g-4">


                      <div className="col-12">
                        <label htmlFor="firstName" className="form-label">Bill Type <span className="text-danger">*</span></label>
                        <select   className={`site-input ${errors.bills ? 'error-input' : ''}`} {...register('bills', {required: true})}  value={bills}  onChange={(e) => setBills(e.target.value)}>
                          <option value="">Select</option>
                          {billsData?.map((data:any) => (
                            <option key={data.id} value={data.id}>{data.bill_name}</option>
                          ))}
                        </select>
                        <p className="pt-2 italic-text light-text sm-text">Select the bill you want to pay for</p>
                        {errors.bills && <p className="error-text">This field is required</p>}
                      </div> 


                      <div className="col-12">
                        <label htmlFor="firstName" className="form-label">Payment Method <span className="text-danger">*</span></label>
                        <select   className={`site-input ${errors.paymentMethod ? 'error-input' : ''}`} {...register('paymentMethod', {required: true})}  value={paymentMethod}  onChange={(e) => setPaymentMethod(e.target.value)}>
                          <option value="">Select</option>
                          {paymentMethodData?.map((data:any) => (
                            <option key={data.id} value={data.id}>{data.name}</option>
                          ))}
                        </select>
                        <p className="pt-2 italic-text light-text sm-text">Select payment method you would like to use</p>
                        {errors.paymentMethod && <p className="error-text">This field is required</p>}
                      </div> 


                      <div className="col-12">
                        <button disabled={disableButton} type="submit" className={`Button site-btn px-3`}>
                          <span className={`${loader ? 'site-submit-spinner': ''}`}></span>
                          <span className={`${loader ? 'site-submit-btn-visiblity': ''}`}><i className="ri-send-plane-fill me-2"></i> Submit</span>
                        </button>
                      </div>
                    </div>

                  </form>
                </div>
            </div>
          </div>
     
        </div>

      </div>

    </div>
  )
}

export default PayBills