import { useNavigate } from 'react-router-dom'
import video from '../../assets/open-video.mp4'
import './index.css'
import { useVisibility } from '../../providers/VisibilityProvider'
import { fetchNui } from '../../utils/fetchNui'
import { useEffect } from 'react'

export default function OpenPage() {
    const navigate = useNavigate()
    const visibility = useVisibility()

    visibility.setCloseable(false)

    const handleVideoEnd = () => {
        visibility.setVisible(false)
        fetchNui('hideFrame')
        setTimeout(() => {
            navigate('/')
        }, 100)
    }

    useEffect(() => {
        fetchNui('prepareShowroom')
    }, [])

    return (
        <div className="open-wrapper">
            <video className="video" muted autoPlay onEnded={handleVideoEnd}>
                <source src={video} type="video/mp4" />
            </video>
        </div>
    )
}