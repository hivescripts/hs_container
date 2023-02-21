import { useEffect, useState } from "react"
import './index.css'
import { useNavigate } from "react-router-dom"
import { fetchNui } from "../../utils/fetchNui"
import { useVisibility } from "../../providers/VisibilityProvider"
import { useLanguage } from "../../providers/LanguageProvider"

interface CodeValidationResponse {
    valid: boolean
}

export default function EnterCodePage() {
    const [code, setCode] = useState('')

    const visibility = useVisibility()
    const navigate = useNavigate()

    useEffect(() => {
        visibility.setCloseable(true)
    }, [])

    const language = useLanguage()

    const handleConfirm = () => {
        fetchNui<CodeValidationResponse>('validateKey', { key: code }, { valid: true }).then(res => {
            if(!res.valid) return
            navigate('/choose')
        })
    }

    return (
        <div className="frame-1">
            <div className="title-group">
                <h1 className="code-title">{language.getString('enterCode.title')}</h1>
                <p className="code-description">{language.getString('enterCode.description')}</p>
            </div>
            <input type="text" className="component-keyinput component" placeholder="key_xxxxxxxxxxxxxxxxxxxx" onChange={ e => setCode(e.target.value) }/>
            <button className="confirm" onClick={handleConfirm}>{language.getString('enterCode.submit')}</button>
        </div>
    )
}