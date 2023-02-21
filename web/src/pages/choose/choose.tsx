import { useEffect, useState } from 'react'
import icon from '../../assets/iconsax-linear-box1.svg'
import './index.css'
import { useNavigate } from 'react-router-dom'
import { useVisibility } from '../../providers/VisibilityProvider'
import { useLanguage } from '../../providers/LanguageProvider'

export default function ChoosePage() {
    const [selected, setSelected] = useState(-1)

    const visibility = useVisibility()
    const navigate = useNavigate()

    useEffect(() => {
        visibility.setCloseable(false)
    }, [])

    const language = useLanguage()

    const handleSelect = (id: number) => {
        setSelected(id)
        
        // change style
        document.querySelectorAll('.component-2').forEach((el, i) => {
            if (i === id) {
                el.classList.add('selected')
            } else {
                el.classList.remove('selected')
            }
        })
    }

    const handleOpen = () => {
        if (selected === -1) return
        navigate('/open')
    }

    return (
        <div className="frame-1">
            <div className="title-group">
                <h1 className="container-auswhlen">{language.getString('chooseContainer.title')}</h1>
                <p className="whle-einen-containe">{language.getString('chooseContainer.description')}</p>
            </div>
            <div className="chooseables chooseables-1">
                <div className="chooseables-1">
                    {Array.from({ length: 3 }).map((_, i) => (
                        <div className="component-2" onClick={() => handleSelect(i)} key={i}>
                            <img className="iconsax-linearbox1" src={icon} alt="Iconsax/Linear/box1" />
                        </div>
                    ))}
                </div>
                <div className="chooseables-1">
                    {Array.from( { length: 3 }).map((_, i) => (
                        <div className="component-2" onClick={() => handleSelect(3 + i)} key={3 + i}>
                            <img className="iconsax-linearbox1" src={icon} alt="Iconsax/Linear/box1" />
                        </div>
                    ))}
                </div>
            </div>
            <button className="open" onClick={handleOpen}>{language.getString('chooseContainer.submit')}</button>
        </div>
    )
}