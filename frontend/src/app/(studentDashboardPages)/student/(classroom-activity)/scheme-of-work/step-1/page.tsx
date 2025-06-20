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
  const [term, setTerm] = useState('')
  const [classID, setClassID] = useState('')

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
    TermFunction,
    termData,




  } = useContext(AllDataContext)!;

  const UserDetails = async () =>{
    try{
      let response = await fetch(`http://127.0.0.1:8000/api/students/${authTokens?.user_id}/`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authTokens?.access}`,
        },

      })
      const data = await response.json()

      if(response.ok){
        setClassID(data.student_class)
      }
    }catch{
      console.log('error')
    }

  }

  


  const {
    register,
    handleSubmit,
    formState: {errors, isValid},
  } = useForm<any>();










  const onSubmit = (data: FormData, e:any) => {
    setLoader(true)
    router.push(`/student/scheme-of-work/step-1/${term}/${classID}`)
  }


  
  useEffect(() => {
    TermFunction()
    UserDetails()
    setLoader(false)
  }, [])





  return (
    <div>

      <div className="container-lg  pt-5 mb-5 pb-4">
        <div className='row justify-content-center'>
          <div className="col-sm-6">
            <div className="site-boxes border-radius-10px">
              <div className="border-bottom1 p-3">
                <p className='text-center'>Step 1</p>
              </div>

              <div className='mt- p-3'>
                  <form onSubmit={handleSubmit(onSubmit)}>
                    <div className="row g-4">
                      <div className="col-12">
                        <label htmlFor="firstName" className="form-label">Term <span className="text-danger">*</span></label>
                        <select   className={`site-input ${errors.term ? 'error-input' : ''}`} {...register('term', {required: true})}  value={term}  onChange={(e) => setTerm(e.target.value)}>
                          <option value="">Select</option>
                          {termData?.map((data:any) => (
                            <option key={data.id} value={data.id}>{data.name}</option>
                          ))}
                        </select>
                        <p className="pt-2 italic-text light-text sm-text">Select term you would like to see the scheme of work</p>
                        {errors.term && <p className="error-text">This field is required</p>}
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